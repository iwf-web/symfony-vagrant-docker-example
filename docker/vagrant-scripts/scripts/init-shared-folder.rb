# -*- mode: ruby -*-
# vi: set ft=ruby :

def init_shared_folder(config, settings)

    if settings['shared_folder_type'] == "rsync"
        # args: do not copy symlinks
        config.vm.synced_folder "../../", "/vagrant", type: "rsync",
          rsync__exclude: settings['rsync_exclude'],
          rsync__chown: true,
          rsync__args: ["--verbose", "--archive", "--delete", "-z"]
    else
        config.vm.synced_folder "../../", "/vagrant", type: "nfs", mount_options: ["rw", "tcp", "nolock", "async"], nfs_udp: false
        config.nfs.map_uid = Process.uid
        config.nfs.map_gid = Process.gid
    end

end
