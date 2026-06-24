### Using **RxGarages** and **RxBanking** with **vms_housing**

To integrate **RxGarages** and **RxBanking** with **vms_housing**, follow these steps:

1. Navigate to the following directory:

   ```
   vms_housing\integration\[banking]
   ```

2. Open the banking integration configuration and locate:

   ```
   DetectActiveBanking
   ```

   Add:

   ```lua
   'RxBanking',
   ```

3. Replace the existing **RxBanking.lua** file with the one provided by us.

4. Navigate to the following directory:

   ```
   vms_housing\integration\[garages]
   ```

5. Open the garage integration configuration and locate:

   ```
   DetectActiveGarage
   ```

   Add:

   ```lua
   'RxGarages',
   ```

6. Replace the existing **RxGarages.lua** file with the one provided by us.

7. Save all files and restart the resource.

**vms_housing** will now use **RxGarages** as its garage system and **RxBanking** as its banking system.

**Script by:** [Vames Store](script by **vames**: https://www.vames-store.com/)
**Integration by:** [GR-Scripts](https://discord.gg/y6zJRUEhkT)

