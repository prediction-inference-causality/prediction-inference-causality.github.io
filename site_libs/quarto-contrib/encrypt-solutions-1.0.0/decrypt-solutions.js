// decrypt-solutions.js
// Client-side decryption for encrypted solutions

(function() {
  'use strict';

  class SolutionDecryptor {
    constructor() {
      this.weekKeys = new Map(); // week number -> CryptoKey
      this.maxWeekUnlocked = 0;
    }

    async init() {
      // Restore cached keys from localStorage
      await this.restoreKeys();
      
      // Decrypt any solutions we can
      await this.decryptAll();
      
      // Set up UI
      this.setupUI();
    }

    async restoreKeys() {
      const cached = localStorage.getItem('solution-week-keys');
      if (!cached) return;
      
      try {
        const data = JSON.parse(cached);
        for (const [weekStr, keyHex] of Object.entries(data)) {
          const week = parseInt(weekStr);
          const key = await this.importKey(keyHex);
          this.weekKeys.set(week, key);
          if (week > this.maxWeekUnlocked) {
            this.maxWeekUnlocked = week;
          }
        }
      } catch (e) {
        console.error('Failed to restore keys:', e);
        localStorage.removeItem('solution-week-keys');
      }
    }

    async cacheKeys() {
      const data = {};
      for (const [week, key] of this.weekKeys) {
        const raw = await crypto.subtle.exportKey('raw', key);
        data[week] = this.bufToHex(new Uint8Array(raw));
      }
      localStorage.setItem('solution-week-keys', JSON.stringify(data));
    }

    async importKey(keyHex) {
      const keyData = this.hexToBuf(keyHex);
      return crypto.subtle.importKey(
        'raw',
        keyData,
        { name: 'AES-CBC' },
        true,
        ['decrypt']
      );
    }

    async deriveKeyFromPassword(password, salt) {
      const enc = new TextEncoder();
      const keyMaterial = await crypto.subtle.importKey(
        'raw',
        enc.encode(password),
        'PBKDF2',
        false,
        ['deriveBits', 'deriveKey']
      );
      
      return crypto.subtle.deriveKey(
        {
          name: 'PBKDF2',
          salt: enc.encode(salt),
          iterations: 600000,
          hash: 'SHA-256'
        },
        keyMaterial,
        { name: 'AES-CBC', length: 256 },
        true,
        ['decrypt']
      );
    }

    // Given a password for week N, derive passwords and keys for weeks 1 through N-1
    async deriveEarlierWeeks(weekNPassword, weekN) {
      const keys = new Map();
      const passwords = new Map();
      
      // Derive encryption key for week N
      const weekNKey = await this.deriveKeyFromPassword(weekNPassword, 'encrypt-solution');
      keys.set(weekN, weekNKey);
      passwords.set(weekN, weekNPassword);
      
      // Chain backwards: week N-1 password = PBKDF2(week N password, "derive-prev-week")
      let currentPassword = weekNPassword;
      for (let w = weekN - 1; w >= 0; w--) {
        // Derive previous week's password
        const prevPasswordKey = await this.deriveKeyFromPassword(currentPassword, 'derive-prev-week');
        const rawKey = await crypto.subtle.exportKey('raw', prevPasswordKey);
        const passwordHex = this.bufToHex(new Uint8Array(rawKey));
        
        // Convert hex to words (must match generate-keys.sh)
        const words = this.hexToWords(passwordHex);
        currentPassword = `week${w}-${words}`;
        passwords.set(w, currentPassword);
        
        // Derive encryption key for this week
        const weekKey = await this.deriveKeyFromPassword(currentPassword, 'encrypt-solution');
        keys.set(w, weekKey);
      }
      
      return { keys, passwords };
    }
    
    // Convert first 16 hex chars to 4 words (matches generate-keys.sh)
    hexToWords(hex) {
      const words = [
        'apple', 'banana', 'cherry', 'dragon', 'eagle', 'falcon', 'garden', 'harbor', 'island', 'jungle',
        'kingdom', 'lemon', 'marble', 'nectar', 'orange', 'palace', 'quartz', 'rocket', 'silver', 'thunder',
        'umbrella', 'violin', 'whisper', 'yellow', 'zephyr', 'anchor', 'bridge', 'castle', 'dolphin',
        'ember', 'forest', 'glacier', 'horizon', 'indigo', 'jasmine', 'kaleidoscope', 'lantern',
        'meadow', 'nimbus', 'orchid', 'penguin', 'quantum', 'rainbow', 'sphinx', 'tornado',
        'universe', 'vertex', 'waterfall', 'xenon', 'yonder', 'zenith', 'alpine', 'bamboo',
        'cosmos', 'delta', 'emerald', 'fable', 'granite', 'helium', 'ivory', 'jewel',
        'kinetic', 'lotus', 'magnetic', 'nova', 'obsidian', 'prism', 'quasar', 'ripple',
        'stellar', 'twilight', 'ultra', 'velvet', 'wisteria', 'axiom', 'blazer',
        'crystal', 'dazzle', 'eclipse', 'flicker', 'glow', 'haze', 'illuminate',
        'jubilee', 'kindle', 'luminous', 'mist', 'nebula', 'opal', 'phosphor',
        'quiver', 'radiant', 'shimmer', 'tidal', 'uplift', 'vibrant', 'whirl',
        'azure', 'bliss', 'calm', 'dream', 'echo', 'float', 'gentle', 'hush',
        'infinite', 'jazz', 'keen', 'lunar', 'mystic', 'night', 'oasis', 'pearl',
        'quiet', 'reverie', 'serene', 'tranquil', 'unity', 'vision', 'wonder'
      ];
      
      const result = [];
      for (let i = 0; i < 4; i++) {
        const chunk = hex.substr(i * 4, 4);
        const num = parseInt(chunk, 16);
        const idx = num % words.length;
        result.push(words[idx]);
      }
      return result.join('-');
    }

    async unlockWithKey(keyInput) {
      // Parse the key format: weekN-word-word-word
      const match = keyInput.trim().match(/^week(\d+)-(.+)$/i);
      if (!match) {
        return { success: false, error: 'Invalid key format. Expected: week3-word-word-word' };
      }
      
      const week = parseInt(match[1]);
      const password = keyInput.trim(); // full weekN-word-word-word string
      
      try {
        // Derive this week's key and all earlier weeks (cascading)
        const { keys: newKeys } = await this.deriveEarlierWeeks(password, week);
        
        // Test decryption on a solution to verify the key works
        const testResult = await this.testDecryption(newKeys, week);
        if (!testResult.success) {
          return { success: false, error: 'Invalid key - decryption failed' };
        }
        
        // Store all the keys
        for (const [w, k] of newKeys) {
          this.weekKeys.set(w, k);
        }
        if (week > this.maxWeekUnlocked) {
          this.maxWeekUnlocked = week;
        }
        
        // Cache and decrypt
        await this.cacheKeys();
        await this.decryptAll();
        
        return { success: true, weeksUnlocked: week };
      } catch (e) {
        console.error('Unlock failed:', e);
        return { success: false, error: 'Invalid key' };
      }
    }

    async testDecryption(keys, maxWeek) {
      // Find a solution div that we should be able to decrypt
      const solutions = document.querySelectorAll('.encrypted-solution');
      for (const el of solutions) {
        const week = parseInt(el.dataset.week);
        if (week <= maxWeek && keys.has(week)) {
          try {
            const iv = this.hexToBuf(el.dataset.iv);
            const ciphertext = this.b64ToBuf(el.dataset.content);
            const key = keys.get(week);
            
            await crypto.subtle.decrypt(
              { name: 'AES-CBC', iv: iv },
              key,
              ciphertext
            );
            return { success: true };
          } catch (e) {
            return { success: false };
          }
        }
      }
      // No solutions to test - assume success
      return { success: true };
    }

    async decryptAll() {
      const solutions = document.querySelectorAll('.encrypted-solution');
      
      for (const el of solutions) {
        const week = parseInt(el.dataset.week);
        if (!this.weekKeys.has(week)) continue;
        
        // Already decrypted?
        if (el.classList.contains('decrypted')) continue;
        
        try {
          const iv = this.hexToBuf(el.dataset.iv);
          const ciphertext = this.b64ToBuf(el.dataset.content);
          const key = this.weekKeys.get(week);
          
          const decrypted = await crypto.subtle.decrypt(
            { name: 'AES-CBC', iv: iv },
            key,
            ciphertext
          );
          
          const html = new TextDecoder().decode(decrypted);
          const contentEl = el.querySelector('.encrypted-solution-content');
          const lockedEl = el.querySelector('.encrypted-solution-locked');
          
          contentEl.innerHTML = html;
          contentEl.style.display = 'block';
          lockedEl.style.display = 'none';
          el.classList.add('decrypted');
          
          // Hide lock icon when unlocked (visibility to preserve spacing)
          const lockIcon = el.querySelector('.solution-lock-icon');
          if (lockIcon) lockIcon.style.visibility = 'hidden';
        } catch (e) {
          console.error(`Failed to decrypt week ${week} solution:`, e);
        }
      }
      
    }

    forgetKeys() {
      this.weekKeys.clear();
      this.maxWeekUnlocked = 0;
      localStorage.removeItem('solution-week-keys');
      
      // Re-lock all solutions
      document.querySelectorAll('.encrypted-solution.decrypted').forEach(el => {
        el.classList.remove('decrypted');
        el.querySelector('.encrypted-solution-content').style.display = 'none';
        el.querySelector('.encrypted-solution-content').innerHTML = '';
        el.querySelector('.encrypted-solution-locked').style.display = 'block';
        const lockIcon = el.querySelector('.solution-lock-icon');
        if (lockIcon) lockIcon.style.visibility = '';
      });
    }

    setupUI() {
      // Add click handlers to lock icons
      document.querySelectorAll('.solution-lock-icon').forEach(icon => {
        if (icon.dataset.listenerAdded) return;
        icon.dataset.listenerAdded = 'true';
        icon.style.cursor = 'pointer';
        
        icon.addEventListener('click', async (e) => {
          e.stopPropagation();
          const solution = icon.closest('.encrypted-solution');
          if (solution && solution.classList.contains('decrypted')) return;
          
          const key = prompt('Enter solution key (e.g. week3-word-word-word):');
          if (!key) return;
          
          const result = await this.unlockWithKey(key.trim());
          if (!result.success) {
            alert(result.error || 'Invalid key');
          }
        });
      });
    }



    // Utility functions
    hexToBuf(hex) {
      const bytes = new Uint8Array(hex.length / 2);
      for (let i = 0; i < hex.length; i += 2) {
        bytes[i / 2] = parseInt(hex.substr(i, 2), 16);
      }
      return bytes;
    }

    bufToHex(buf) {
      return Array.from(buf)
        .map(b => b.toString(16).padStart(2, '0'))
        .join('');
    }

    b64ToBuf(b64) {
      const binary = atob(b64);
      const bytes = new Uint8Array(binary.length);
      for (let i = 0; i < binary.length; i++) {
        bytes[i] = binary.charCodeAt(i);
      }
      return bytes;
    }
  }

  // Initialize when DOM is ready
  async function initDecryptor() {
    window.solutionDecryptor = new SolutionDecryptor();
    await window.solutionDecryptor.init();
  }
  
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initDecryptor);
  } else {
    initDecryptor();
  }
  
  // Handle Quarto's SPA-style navigation
  // Quarto emits a custom event when navigating between pages
  document.addEventListener('quarto-page-loaded', async () => {
    if (window.solutionDecryptor) {
      // Re-setup UI and decrypt solutions on new page
      window.solutionDecryptor.setupUI();
      await window.solutionDecryptor.decryptAll();
    }
  });
  
  // Also handle popstate for back/forward navigation
  window.addEventListener('popstate', async () => {
    setTimeout(async () => {
      if (window.solutionDecryptor) {
        window.solutionDecryptor.setupUI();
        await window.solutionDecryptor.decryptAll();
      }
    }, 100);
  });
})();
