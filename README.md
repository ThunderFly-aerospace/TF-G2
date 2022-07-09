# TF-G2 - Unmanned Autogyro

[![Render previews](https://github.com/ThunderFly-aerospace/TF-G2/actions/workflows/render_previews.yml/badge.svg)](https://github.com/ThunderFly-aerospace/TF-G2/actions/workflows/render_previews.yml)
[![Build printable files](https://github.com/ThunderFly-aerospace/TF-G2/actions/workflows/printable_files.yml/badge.svg)](https://github.com/ThunderFly-aerospace/TF-G2/actions/workflows/printable_files.yml)

[![ThuderFly_TFG2_training_autogyro_prototype](https://user-images.githubusercontent.com/5196729/144823035-37a70a1a-de21-4eb6-ab80-2aa2d4ea78db.gif)](http://www.youtube.com/watch?v=6PtS-MwnM_8)

[TF-G2](https://www.thunderfly.cz/tf-g2.html) autogyro is well-suited for training of UAV operators and for gaining experience with autogyro mission planning. TF-G2 is limited to light payloads, but it shares all the specific properties of larger autogyros in our offering. It may find application in less demanding flight operations, however its main purpose is being a tool for low-cost application practice. The autogyro’s small size leads to easy transport, repairs and maintenance.
To enhance the ease of learnig of autogyro technology, we made possible to [simulate TF-G2 flight](https://github.com/ThunderFly-aerospace/PX4-FlightGear-Bridge) prior the real flight training.

![TF-G2 during flight](/doc/img/TF-G2_fly_clouds.jpg)

## The main design highlights

  * High repairability and easy maintenance
  * Use of 3D printing flexibility
  * Predictable behavior in flight
  * Micro payload load capacity suitable for multiple types of [atmospheric sensors](https://www.thunderfly.cz/tf-atmon.html)
  * [Simulation model available](https://github.com/ThunderFly-aerospace/FlightGear-TF-G2)
  * [Car roof takeoff ready](https://github.com/ThunderFly-aerospace/TF-SIMPLEPLATFORM)

Based on that features the TF-G2 is perfectly suitable for [atmospheric measurement applications](https://www.thunderfly.cz/tf-atmon.html). That could be ilustrated by sucessful instegration of multiple sensor types. 

![TF-G2 in hangar](./doc/img/TF-G2_hangar.png)
![TF-G2 with installed THUNDERMILL electric field sensor](./doc/img/TF-G2_THUNDERMILL.jpg)

## Why autogyro? 

![Autogyro](https://imgs.xkcd.com/comics/autogyros.png)

In contrast to well known [VTOL](https://en.wikipedia.org/wiki/VTOL) aircrafts. The autogyro could be considered as a short take-off and vertical landing aircraft ([STOVL](https://en.wikipedia.org/wiki/STOVL)). Therefore it is suitable for large wide range of different applications. The main advantages to other well known arframes: 

* Ability to take off and land using only a very short runway (almost zero lenght).
* High resistance to weather conditions, especially gusts of wind or thermals.
* A unpowered rotor enabling it to operate in an autorotation mode (one of the helicopter’s emergency modes as well). Consequently, it does not need to actively change a flight mode in case of failure (it does not need a parachute or other actively working devices). Its flight is thus inherently stable at all times.
* Absence of a downwash - during take-off or landing the creating an unwanted swirling of dust is eliminated.
* Low lift-to-drag ratio that can be adjusted by construction parameters. This ability can be useful because while an unmanned autogyro cannot fly very far in the case of failure (as is the case of a conventional airplane), the flight is still safe and aircraft does not fall (as is typical for multicopter or helicopter).

The outogyro has generally many construction variants. The one, which is in the scope of this repository has a fully tilted rotor. The main advantage of this construction feature is obtaining better controlabillity over its speed range. It can also be controlled down to zero forward airspeed, compared to classical rudder/elevator setup.

## Repository content

This repository contains open-source design files of the autogyro construction. The most components are 3D-printed. However the printable data (gcodes) are generated by our special software suite - processor3D. It is required that parts are sliced properly according to material to make sure that resulted 3D printed parts could be used safely for the flight. **Therefore for safety reasons we do not recommend to attempt to slice the parts yourself. It is better to contact us.**

The product, support or accesories could be obtained from [ThunderFly s.r.o.](https://www.thunderfly.cz/), via an email to info@thunderfly.cz .


### Contribution

In case you want to contribute to the open-source project we have a [contribution guideline](https://github.com/ThunderFly-aerospace/TF-G2/blob/4s/CONTRIBUTING.md). Your contribution is very welcome! For a contribution, you can get access to the optimized and safe printable files (gcodes).

## References 

* [TF-G2: PX4 powered autogyro](https://static.sched.com/hosted_files/px4summit2021/ca/TF-G2%20PX4%20powered%20autogyro.pdf)
* ["Flight control system for a small autogyro" bachelor thesis](https://dspace.cvut.cz/handle/10467/101004)
