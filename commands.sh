# ============================================================
# AWS EBS + Linux Storage Operations
# Production-Oriented Command Reference
# ============================================================

lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS # Inventory block devices and identify the EBS volume before making changes
df -hT # Review currently mounted filesystems, filesystem types, and capacity
sudo lsblk -f # Inspect filesystem UUIDs, types, and mount relationships
sudo file -s /dev/nvme1n1 # Confirm whether the target EBS device contains an existing filesystem before formatting

sudo mkfs.xfs /dev/nvme1n1 # Create an XFS filesystem on a confirmed empty EBS volume; destructive operation
sudo mkdir -p /data # Create the standard application/data mount point
sudo mount /dev/nvme1n1 /data # Mount the XFS filesystem on the Linux mount point
findmnt /data # Confirm the device, filesystem type, and mount options currently used for /data
df -hT /data # Verify mounted capacity and filesystem type

sudo touch /data/cloud-test.txt # Perform a controlled write test against the newly mounted EBS storage
ls -lh /data # Confirm that the test file was successfully created
sudo rm -f /data/cloud-test.txt # Remove the temporary validation file after testing

sudo blkid /dev/nvme1n1 # Retrieve the filesystem UUID for stable persistent mounting
sudo vim /etc/fstab # Add the UUID-based mount configuration for persistence across reboot
sudo mount -a # Validate /etc/fstab without rebooting; errors indicate configuration problems
findmnt /data # Confirm that /data is mounted using the expected persistent configuration

lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS # Re-check the device after increasing the EBS volume size in AWS
df -hT /data # Confirm whether the filesystem size has changed after the underlying EBS resize

sudo xfs_growfs -d /data # Grow the mounted XFS filesystem to consume the newly available EBS capacity
df -hT /data # Verify that the XFS filesystem now reflects the expanded EBS capacity
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS # Final storage topology verification after filesystem expansion

sudo umount /data # Unmount the filesystem only when the application is stopped and the mount is no longer in use
findmnt /data # Verify that /data is no longer mounted
