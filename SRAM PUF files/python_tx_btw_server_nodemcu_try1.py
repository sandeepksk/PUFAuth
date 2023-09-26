import csv
import random
import socket

# Define UDP server address (NodeMCU)
NODEMCU_IP = '192.168.195.157'
NODEMCU_PORT = 8888  # Port for communication with NodeMCU
SERVER_IP = '192.168.195.111'
SERVER_PORT = 5201  # Port for communication with the server

# Use a raw string for the file path
csv_file_path = r"D:\sandeep\PUFAuth-main\IoT-PUF\enrollment\CRPSTRY11.csv"

# Open and read the CSV file
with open(csv_file_path, 'r') as csv_file:
    reader = csv.reader(csv_file)
    next(reader)  # Skip the header row (IDs, challenges, responses)
    challenges = [row[1] for row in reader]  # Extract challenges from the middle column

# Select a random challenge
random_challenge = random.choice(challenges)

# Print the selected challenge
print("Selected Challenge: ", random_challenge)

# Create a UDP socket for communication with NodeMCU
udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Send the challenge to NodeMCU
udp_socket.sendto(random_challenge.encode(), (NODEMCU_IP, NODEMCU_PORT))

# Receive data from NodeMCU
response, addr = udp_socket.recvfrom(1024)
print("Received data from NodeMCU:", response.decode())

# Send the received data to the server
server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server_socket.sendto(response, (SERVER_IP, SERVER_PORT))

# Close the sockets
udp_socket.close()
server_socket.close()
