set -e

usage () { echo "Usage: $0 [-n <node>]" 1>&2; exit 1; }

while getopts ":n:" o; do
  case "${o}" in
      n) x=${OPTARG}
      ;;
      *) usage
      ;;
     : ) echo "Option -$OPTARG requires an argument" >&2
     exit
     ;;
  esac
done
shift $((OPTIND -1))

if [ -z "${x}" ]; then
    usage
fi

NODE=${x}
echo "**** Set prerequisites to reach $NODE ****"

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
# Exclude the current node from host checking
cat > ~/.ssh/config <<EOF
Host $NODE
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
# echo the IP to /etc/hosts
echo $NODE | sudo tee -a /etc/hosts &>/dev/null
chmod 700 /home/vagrant/.ssh
# "**** Copy SSH ID ****"
sshpass -p vagrant ssh-copy-id $NODE
# Set permissions
sudo chmod 0600 /home/vagrant/.ssh/config
# Restart the ssh service
sudo service ssh restart
echo "**** Check connectivity to $NODE ****"
for srv in $NODE; do echo $srv:; ssh -o StrictHostKeyChecking=no $srv uptime; done
exit 0
