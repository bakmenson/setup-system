#!/bin/bash

systemctl enable sddm.service

systemctl enable ntpd.service

systemctl start ntpd.service

systemctl enable cronie.service

systemctl enable sshd.service

