# TF-G2 - Unmanned Autogyro Development Kit

[![Render previews](https://github.com/ThunderFly-aerospace/TF-G2/actions/workflows/render_previews.yml/badge.svg)](https://github.com/ThunderFly-aerospace/TF-G2/actions/workflows/render_previews.yml)
[![Build printable files](https://github.com/ThunderFly-aerospace/TF-G2/actions/workflows/printable_files.yml/badge.svg)](https://github.com/ThunderFly-aerospace/TF-G2/actions/workflows/printable_files.yml)

Click on the following video to quickly get an overview: 
[![ThuderFly_TFG2_training_autogyro_prototype](https://user-images.githubusercontent.com/5196729/144823035-37a70a1a-de21-4eb6-ab80-2aa2d4ea78db.gif)](http://www.youtube.com/watch?v=6PtS-MwnM_8)

[TF-G2](https://www.thunderfly.cz/tf-g2.html) autogyro is well-suited for training UAV operators and for gaining experience with autogyro mission planning. TF-G2 is limited to light payloads, but it shares all the specific properties of larger autogyros in our offering. It may find application in less demanding flight operations, however, its main purpose is to be a tool for low-cost application practice. The autogyro’s small size leads to easy transport, repairs, and maintenance.
To enhance the ease of learning autogyro technology, we made it possible to [simulate TF-G2 flight](https://github.com/ThunderFly-aerospace/PX4-FlightGear-Bridge) prior to the real flight training.

![TF-G2 during flight](/doc/img/TF-G2_fly_clouds.jpg)

## The main design highlights

  * Micro payload load capacity suitable for multiple types of [TF-ATMON atmospheric sensors](https://www.thunderfly.cz/tf-atmon.html)
  * Low audible noise
  * High maneuverability and agility
  * Extreme tolerance to rotor blade damage
  * Repairabile and low maintenance
  * Use of 3D printing flexibility
  * [Simulation model available](https://github.com/ThunderFly-aerospace/FlightGear-TF-G2)
  * [Car roof takeoff ready](https://github.com/ThunderFly-aerospace/TF-SIMPLEPLATFORM)

Based on that features the TF-G2 is perfectly suitable for [atmospheric measurement applications](https://www.thunderfly.cz/tf-atmon.html). That could be illustrated by the [successful integration of multiple sensor types](https://github.com/ThunderFly-aerospace/TFUNIPAYLOAD01). 

## Applications
Here are some examples of existing use cases for TF-G2 as a lightweight sensor carrier. These application-specific use cases extend the integrated sensing possibilities provided by existing autogyro avionics. The inherently existing onboard sensors in avionics are position, time, wind speed direction and velocity, and atmospheric pressure.

### Particulate matter sensing

Particulate matter sensing in the atmosphere is a scientific technique used to monitor and measure the concentration of small solid particles suspended in air, often termed as aerosols. These particles, typically categorized by their size - such as PM2.5 and PM10 - can originate from various sources including combustion processes, industrial emissions, vehicle exhausts, and natural phenomena like dust storms. Sensing and monitoring particulate matter is crucial for environmental health and public safety, as high levels can severely impact air quality, contributing to respiratory and cardiovascular diseases. Moreover, this data aids meteorological predictions and climate models, as particulates influence atmospheric visibility, and can affect the earth's radiation balance, hence playing a role in climate change. The TF-G2 autogyro could be equipped by [TFPM01](https://github.com/ThunderFly-aerospace/TFPM01) particulate matter sensor to measure the concentration of particulate matter in the specified air volume. 

[ ![Watch the video](https://img.youtube.com/vi/KUhktPDEi8I/hqdefault.jpg) ](https://www.youtube.com/watch?v=KUhktPDEi8I)


### Humidity and temperature sensing

Humidity and temperature sensing in [atmospheric vertical sounding](https://en.wikipedia.org/wiki/Atmospheric_sounding) involve the measurement of atmospheric moisture content and temperature at various altitudes. Instruments like the [TFHT01 sensor](https://github.com/ThunderFly-aerospace/TFHT01)  from ThunderFly are pivotal in collecting this data. These compact and lightweight sensors, designed specifically for UAV applications, can withstand varied atmospheric conditions and provide accurate, high-resolution measurements. Acquiring this data is essential for meteorological forecasts and climate studies, as the vertical distribution of temperature and humidity influences weather patterns, storm development, and overall climate dynamics. The [TFHT01](https://github.com/ThunderFly-aerospace/TFHT01) sensor, with its specialized design and precise data, has become an instrumental tool in advancing our understanding of these complex atmospheric processes.

![TF-G2 atmospheric sounding experiment](https://github.com/ThunderFly-aerospace/TFHT01/blob/TFHT01B/doc/img/TFHT_vertical_profile_measurement.png)

An example of an atmospheric profiling experiment. The time difference between the reference and the experiment was around 6 hours. 

### Electric field monitoring

Electric field monitoring via TF-G2 UAV autogyro near thunderstorms entails the measurement of atmospheric electrical properties associated with storm activities. The charged particles present in thunderstorms create strong electric fields, which can be accurately detected and monitored by [THUNDERMILL01 sensor](https://github.com/UniversalScientificTechnologies/THUNDERMILL01). The TF-G2 autogyro, equipped with specialized sensors, can navigate challenging weather conditions and provide critical, real-time data on the strength and spatial distribution of the electric fields. Understanding these fields is crucial in predicting lightning activity, improving weather forecasts, and contributing to research on storm dynamics and atmospheric electricity. This UAV-autogyro technology offers a unique, mobile platform to safely investigate these intense electrical phenomena without putting human lives at risk.

![TF-G2 with installed THUNDERMILL electric field sensor](./doc/img/TF-G2_THUNDERMILL.jpg)

### Ionising radiation monitoring

Ionizing radiation monitoring in the atmosphere involves detecting and quantifying radioactive particles using specialized devices like semiconductor-based ionizing radiation [AIRDOS03](https://www.ust.cz/UST-dosimeters/AIRDOS/#airdos03-uavdos) spectrometer and dosimeter. This instrument measures the intensity and spectral distribution of ionizing radiation, such as alpha, beta, gamma, and X-ray emissions that can originate from natural sources or human activities. The compact and precise nature of semiconductor-based devices allows for sensitive detection and accurate quantification of radiation levels. Monitoring atmospheric ionizing radiation is vital for assessing environmental radiation hazards, managing nuclear emergencies, and supporting research in fields such as meteorology, geology, and climate science. These advanced devices help ensure public safety and enhance our understanding of natural and anthropogenic radioactive processes in the atmosphere.

## Why autogyro? 

![Autogyro](https://imgs.xkcd.com/comics/autogyros.png)

In contrast to the well-known [VTOL](https://en.wikipedia.org/wiki/VTOL) aircraft designs. The autogyro could be considered a short take-off and vertical landing aircraft ([STOVL](https://en.wikipedia.org/wiki/STOVL)). Therefore it is suitable for a wide range of different applications. The main advantages to other well-known airframes: 

* Ability to take off and land using only a very short runway (almost zero length).
* High resistance to weather conditions, especially gusts of wind or thermals.
* A unpowered rotor enabling it to operate in an autorotation mode (one of the helicopter’s emergency modes as well). Consequently, it does not need to actively change a flight mode in case of failure (it does not need a parachute or other actively working devices). Its flight is thus inherently stable and safe at all times.
* Autogyro has significantly reduced audible noise due to the slowly rotating rotor and propeller. 
* Absence of a downwash - during take-off or landing the creation of an unwanted swirling of dust is eliminated.
* Low lift-to-drag ratio that can be adjusted by construction parameters. This ability can be useful because an unmanned autogyro cannot fly very far in the case of controls failure (as is the case of a conventional airplane), the flight is still safe and the autogyro cannot fall (as is typical for multi-copters or wrongly piloted helicopters).

The autogyro has generally many construction variants. The one, which is in the scope of this repository has a fully tilted rotor. The main advantage of this construction feature is obtaining better controllability over its wide airspeed range. It can also be controlled down to zero forward airspeeds, compared to a classical rudder/elevator setup.

## Repository content

![TF-G2 in hangar](./doc/img/TF-G2_hangar.png)

This repository contains open-source design files of the autogyro construction. Most components are 3D-printed. However, the printable data (gcodes) are generated by our special software suite - processor3D. It is required that parts are sliced properly according to the material to make sure that resulted in 3D-printed parts could be used safely for the flight. **Therefore for safety reasons we do not recommend attempting to slice the parts yourself. It is better to contact us.**

The product, support, or accessories could be obtained from [ThunderFly s.r.o.](https://www.thunderfly.cz/), via an email to info@thunderfly.cz .

### Contribution

In case you want to contribute to the open-source project we have a [contribution guideline](https://github.com/ThunderFly-aerospace/TF-G2/blob/4s/CONTRIBUTING.md). Your contribution is very welcome! For a contribution, you can get access to the optimized and safe printable files (gcodes).

## References 

* [TF-G2: PX4 powered autogyro](https://static.sched.com/hosted_files/px4summit2021/ca/TF-G2%20PX4%20powered%20autogyro.pdf)
* ["Flight control system for a small autogyro" bachelor thesis](https://dspace.cvut.cz/handle/10467/101004)
