## IOT - PUF
This repository serves as a comprehensive guide for setting up SRAM (Static Random Access Memory) and running code on Arduino devices. It provides detailed instructions and resources to help you successfully integrate SRAM with Arduino to use it as IOT device which needs to be authenticated.

#### Components Required

The components required to setup the IOT device are: (click on the links to buy the respective component)

- [Ardunio Mega 2560](https://store-usa.arduino.cc/products/arduino-mega-2560-rev3)

<center>
<img src="https://robu.in/wp-content/uploads/2019/12/Arduino-Mega-2560-ATmega2560-4.jpg" alt="Ardunio Mega 2560" width="300" height="250">
</center>

- [WiFi Module](https://robu.in/product/esp-01s-esp8266-wifi-module/)

<center>
<img src="https://i0.wp.com/protocentral.com/wp-content/uploads/2020/10/5479-1.jpg?w=600&ssl=1" alt="WiFi module" width="150">
</center>


- [SD Card module](https://robu.in/product/micro-sd-card-module/)

<center>
<img src="https://cdn.shopify.com/s/files/1/0262/6564/9240/products/HatchnHack_Makerspace_HNH_cart_components-25_74699f9b-2c9e-4add-8b9b-01201f4118ff_800x.jpg?v=1667039940" alt="SD Card module" width="150">
</center>

- [SRAM Cypress CY62256NLL](https://www.tme.com/in/en/details/cy62256nll-55snxi/parallel-sram-memories-integ-circ/infineon-cypress/)

<center>
<img src="https://ce8dc832c.cloudimg.io/v7/_cdn_/77/CA/90/00/0/633975_1.jpg?width=640&height=480&wat=1&wat_url=_tme-wrk_%2Ftme_new.png&wat_scale=100p&ci_sign=5585e6c51c1e875930a8668ea0a7cbc238affdf9" alt="SRAM Cypress CY62256NLL" width="100">
</center>

- [Bread Board](https://www.amazon.in/Generic-Elementz-Solderless-Piecesb-Circuit/dp/B00MC1CCZQ/ref=sr_1_5?keywords=Bread+Boards&sr=8-5)

- [Jumper Wires](https://www.amazon.in/ApTechDeals-Jumper-Female-breadboard-jumper/dp/B074J9CPV3/ref=pd_bxgy_img_sccl_1/260-8460025-5832429?content-id=amzn1.sym.2f895d58-7662-42b2-9a98-3a18d26bef33&pd_rd_i=B074J9CPV3&th=1)

#### Repository structure
There are two folder inside each of which represent a phase of IOT device to be used in the authentication:

- **enrollment**
In this phase many Challenge Response Pairs (CRPS) are generated from the SRAM using Ardunio and these CRPS are sent to the database of the verifier to store them securely.Verifier uses them at later point of time to authenticate the IOT PUF. The source codes and details can be found in the [enrollment](./enrollment) folder.

- **validation**
In validation phase, a challenge from the stored CRPs is given to the PUF by the verifier. Afterwards, the PUF response from this challenge is compared with the corresponding response from the database. The response is considered to be valid if there is a CRP from the stored CRPs related to this challenge and response. The source codes and details can be found in the [validation](./validation) folder.


