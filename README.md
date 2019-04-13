# terraform_code
Example of TF code to:
1. create S3 Bucket
2. move tf state to remote on new created S3 bucket
3. launch ec2 instance Rhel
4. create and attach ssh keys
5. create and attach Security Group, My Public IP added dynamically to allow inbound TLS/SSH connection
6. return as output public ip of Ec2 instance 

To do:

7. automatically connect via SSH from my desktop to ec2 instance using private key
8. run ansbile to deploy snen emulator https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/snes9x-gtk/snes9x-1.53-src.tar.bz2
9. Enable screen X11 Forwarding to my IP https://www.techotopia.com/index.php/Displaying_CentOS_Applications_Remotely_(X11_Forwarding)
10. Lunch emulator snes9x-1.53-src/unix/docs/readme_unix.html
