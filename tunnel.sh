#!/usr/bin/env bash
ssh -i /vagrant/epam-lab.pem -o "StrictHostKeyChecking=no" -R 12345:localhost:12345 ec2-user@13.58.138.141
