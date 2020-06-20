---
title: "Moona: Part II - HAX"
date: "2019-11-23"
author: "dstoiko"
tags: [moona, shenzhen, hardware, prototyping]
---

_This is the second article from a series on the story of Moona. Check out the other ones here [Moona: Start-up Story Series](/posts/moona-0-series)._


# HAX

Before flying to Shenzhen, actually as soon as we got accepted into the program, I watched a documentary that had been released by Wired just a few months before. It was starring Bunnie Huang, a brilliant electronics engineer who, while still a grad student at MIT, became the first person to hack the Xbox firmware back in December 2001. He's now an electronics consultant and actually works with HAX teams to advise them on all things related to electrical engineering, hardware product development and manufacturing. Here's the documentary which I highly recommend:

{{< youtube SGJ5cZnoodY >}}

Arriving at HAX was quite an experience. It was the very first time we had an office space dedicated to hardware start-ups, and shared by such awesome projects that ranged from robotics to biotech. The first thing we did was take a few office spots in the big open space...

{{< figure src="./media/IMG_2698.png" title="HAX Open Space" alt="HAX Open Space" caption="Big open space with around 120 seats. Alumni were allowed to occupy roughly half of the spots" >}}

Then we visited the workshop, where we were given our own toolbox-cart, with brand-new mechanical and electrical engineering tools for prototyping. There was a mechanical side with milling, laser-cutting, 3D-printing and all the shared tools we needed to quickly get a prototype to work. The other side was dedicated to electrical engineering, with soldering stations, multimeters, oscilloscopes and all kinds of cables and accessories, again to make prototyping quick and easy.

{{< figure src="./media/IMG_2701.png" title="HAX Workshop" alt="HAX Workshop" caption="The workshop! At that time it was about 200 sq. m., so we had to share benches with other start-ups on a first-come, first-served basis" >}}

Our objective for the upcoming 4 months was to go from a basic works-like prototype to a works-like-looks-like prototype, which meant the following had to happen:

- Product design
- Mechanical (3D CAD) design
- Components sourcing and testing
- Sensor data acquisition and processing
- PCB redesign
- Firmware rewrite
- App and server development
- UX tests and iterations

By the end of the program we had to be ready to make a crowdfunding campaign to start the marketing and sales efforts.

# The Shenzhen Team

We arrived in Shenzhen just after Chinese New Year in February 2017. One of the first things I noticed when we arrived (even in HK where we landed) was how many skyscrapers there were, even for apartment buildings. We hit the road to Shenzhen to go to the HAX offices and get a feel for the city as soon as we could. We were staying at an airbnb which was actually a "homemade" hotel as the owners had just bought a few apartments in a building on the ~12th floor (out of ~30, standard there) and set up a makeshift counter in one of them...

{{< figure src="./media/IMG_2673.png" title="Shenzhen Skyscrapers" alt="Shenzhen Skyscrapers" caption="This is what Shenzhen looks like. Pretty cool huh?" >}}

One of the first recommended experiences is the local food. My prior experiences of Chinese food were mostly at those Chinese "catering" places in Paris, most of which are - I learned that later - originally founded by immigrants from the Wenzhou area, near Shanghai. Food is usually pre-cooked and heated up in a microwave upon order. I hadn't tried any of the authentic foods China had to offer. So my tastebuds (and digestive system) were in completely new territory.

{{< figure src="./media/IMG_2720.png" title="Green Tea Restaurant" alt="Green Tea Restaurant" caption="Enjoying Green Tea restaurant with other HAX teams" >}}

Once we had settled, it was time for some hard work...

We assembled the team for HAX a few weeks before flying to Shenzhen. Each of us had multiple key roles within the team:

- **Coline**: product/go-to-market strategy, hardware product development & prototyping, investor relations, pitching
- **Me**: tech/product strategy, electronics and firmware prototyping, software development, pitching
- **Serge**: hardware prototyping, components sourcing and testing (thermal, sensors), PCB design, CAD design
- **Pierre**: hardware prototyping, components sourcing and testing (hydraulics, sensors), CAD design
- **Edgar**: software development (app, server, firmware), working remotely from France
- **Marion**: marketing, design, crowdfunding campaign planning and management

## Product design

First, we had a kick-off meeting with the lead designer, Noel, a very talented and experienced industrial designer from Ireland working with the HAX teams. We took our existing moodboards and early design concepts, as well as the features we envisioned in our final product, and put them all on the table in order to generate ideas and produce a new design for our looks-like prototype. At that time, we had already made a looks-like version of the device for CES, which had a very strict size constraint.

Noel helped us define the main lines of the industrial design, and the key design attributes, like the colors, the wood finish, the buttons and screen placement, and all the UX considerations which impact the final design, such as the location of the pillow pad, the length of the tubing, as well as the materials to use.

## Mechanical (3D CAD) design

Once we had that design and components sourced and tested, we made a 1:1 scale version using rudimentary materials such as flexible plastic sheets, plexi tanks, and our new PCBA in the making. That was quick, and we had to move forward as the clock was ticking and our first big deadline, "+60" (60 days after the beginning of the program), was fast approaching.

Tyler, a Chinese mechanical engineer equipped with super-fast professional CAD software skills, helped us actually turn the 3D design concepts we had defined with Noel into a 3D-printable CAD design in which all of our mechanical and electronics components fit snugly.

After a few weeks of prototyping, we realized the size constraints we had in mind were way too strict if we were to actually make it work! So we decided to scale the product back up to find a middle ground between our "works-like" and our "looks-like" prototypes.

We had to make roughly 5 iterations of the whole hardware "casing" design in order to get everything to fit properly and even then, it was pretty fragile. Each time, there would be a problem either with waterproofing, or tolerances, or peripherals we had to change and which required additional design revisions.

This constant iteration with UX tests helped us shape the product experience.

## Components sourcing and testing

As soon as we started prototyping in China, we were in contact with suppliers, either in the electronics markets of HuaQiangBei (华强北), the central avenue where HAX was located - all we literally had to do was to go downstairs from the office and find parts - or around Shenzhen in the industrial areas of Bao'an, Dongguan and Guangzhou.

We relied heavily on the [Taobao](https://taobao.com) and [Alibaba](https://1688.com) websites for finding components and establishing contacts with factories. The first impression we got from these websites is just "wow": you can find so many things on there for any purpose, it's also mind-blowing that most of the parts we ordered off the shelf or as factory samples arrived to the HAX office in less than 3 business days. Compare that to the 2 weeks it took on average to get a part while in France, and it just makes so much sense to be there for the prototyping and product development phase.

We tested around 10 different pumps, 15 heating / cooling elements, and 30 different combinations of materials for the pillow pad, comparing their performance and reliability, before we made our final choices. At that time we created our very first BOM (bill of materials), which was still ridiculously high as we were buying parts at very low volume.

## Sensor data acquisition and processing

In order to make our prototype fully work like the idea we had of our final product, we had to add the following sensors:

- A heatsink temperature sensor, to make thermoregulation more efficient and less noisy by regulating fan speed
- An accelerometer, to estimate sleep quality through the user's movements during the night
- An ambient temperature and humidity sensor, to gather more data about the user's sleep environment

We bought one sensor module (breakout board) of each model we could find easily for prototying: the ones we tested were not necessarily the optimal sensors for our needs, but all of them could connect directly to an Arduino development kit (we were using the Arduino Mega board at the time), or equivalent, without having to design a custom circuit for it. Another criterion was that the sensor module should have an easily pluggable C/C++ software library so that we could get results from the sensor without having to write the interfaces from the datasheet. So we had a test setup and could make decisions quickly. The key final considerations we had were whether the sensor works reliably and whether it was easy to integrate it into our prototype - with our final form factor mechanical constraints in mind.

## PCB redesign

The PCB (Printed Circuit Board) we had when we arrived at HAX had several issues that we needed to deal with:

- It was too big to fit into our final size constraint
- It didn't integrate all the functions we needed for the final product

So after around 30 days of testing and prototyping, we set out to redesign the whole PCB.

We started with a new block diagram in order to layout all the basic functions our prototype needed to have. Then we integrated the key components (actuators and sensors) we had selected through initial testing. We also changed the architecture to include a new microcontroller unit (MCU), the ESP32, which integrated BLE and Wi-Fi connectivity.

In order to enable prototyping, we made some decisions which, in retrospect, we probably should have done differently. We used the development kit (ESP32-Devkit-C) of the MCU that we plugged onto female headers on our PCB. The idea was that we could use it independently to prototype with new sensors and actuators on a breadboard, then plug it back on our PCB, or even swap MCU modules at will. The main problem with this approach is that it made the actual physical interfaces more fragile - connectors of any kind are the main weaknesses of an electrical circuit - which caused some headaches while debugging, and posed additional risks. We also added "general purpose" i2c and SPI circuits in order to swap out sensor breakout modules as we tested them, but each one has its own recommended circuits and it caused some headaches and we ended up adding external circuits around the main PCB, which was clumsy. We could have just gone with a simple set of headers for flashing the firmware quickly, decided on sensors and made more revisions of the PCB design, which are quick and cheap to make in Shenzhen anyway, to test things out, but we ended up making the PCB a bit too "crowded"...

## Firmware rewrite

Our firmware when we joined HAX consisted of a set of Arduino sketches that did everything the very basic product needed to do:

- Regulate temperature using a feedback loop between temperature sensors, a heat pump and a water pump
- Handle user interaction through buttons and a simple LCD screen
- Set alarm time and temperature settings each time the user launches a night

Up until that point, it was "good enough" to get people who were interested to test the prototype and get useful UX feedback from them. But at some point, the good ideas suggested through these tests started piling up. We also needed a "looks-like" prototype we could actually sell to backers / customers and show to investors, so we had to include additional features that would push our product to the next level and make it attractive enough that people would want to buy it and support us on a crowdfunding campaign, without going into "feature creep".

In order to achieve that, we:

- separated each component into its own class for cleaner code and to be able to quickly swap out components if we needed to change them
- designed a finite state machine to handle all possible states the product can be in (connecting, settings, night...)
- enabled simple wireless connection with the app
- integrated new sensors and actuators, external memory using SD card storage, and a new LED matrix display to replace the LCD screen

## App and server development

Before HAX, we had a prototype app made at the very beginning of the project, and a few functional mock-ups of the app, made with [Marvel](https://marvelapp.com). That way we could easily test the core features we had in mind for our MVP app and focus on UX first, before doing any major coding.

Once we had iterated enough on UX design ideas using mock-ups, we started planning for software development.

For the tech choices, we spent a few days figuring out which option was best for our needs:

For the app, we needed a simple development workflow and ideally develop once for both platforms as we had limited resources. After considering several options, we settled on React Native (which had already been used for the initial prototype of the app), which meant developing once using JavaScript for an app compiled in both Android and iOS.

For the server, we needed a simple and reliable infrastructure, to handle app interactions (user account, settings, data) through an HTTPS API. We settled on the Go language, as Edgar was already familiar with it and it seemed like a good choice for building a simple and reliable server, with a solid open-source community and proper tools.

## UX tests and iterations

Throughout the program, we set out to build our prototypes in very short cycles, which allowed us to test as much as we could, either on ourselves or on volunteers amongst other HAX teams. We tried to keep a pace of at least one short UX testing session per week, where we would ask people from the office to test each time a different part of the product and give us feedback. We also organized full-night tests at our apartment building, which was useful even though the logistics were cumbersome with fragile prototypes. We had a few water leaks along the way, but it gave us priceless insights that guided development.

# Key Learnings

Here are some key takeaways we got from our HAX experience, which are good to keep in mind and that I wish I knew before starting...
 
1. **Keep it simple**: we tended to underestimate complexity when starting new projects with an optimistic mindset, so always simplifying any design or technical decision saves a lot of bandwidth and headaches down the road.
2. **Think it through**: we tended to rush towards a "workable" solution too often in the development process, and that lead us to waste time when we needed to do revisions or adapt our prototype, so spending one extra day thinking things through is usually well worth it, so it's useful to go against urgency and pressure to solve problems more effectively.
3. **Test everything you can**: although we did test a lot of things, there's always something that slips through the net if you're not careful enough, so going through a simple but exhaustive test checklist avoids bad assumptions that mess everything up.