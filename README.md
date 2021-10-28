# mopidy-with-bt


docker build -t saikek/mopidy-with-bt .
docker run --privileged --net=host -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket -it saikek/mopidy-with-bt


# List bt dest

hcitool dev

# Start bluealsa
bluealsa -B=16 --device=hci0


# Mopdiy play


mpc ls
mpc play
mpc add