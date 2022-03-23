projects_en = [
  name: "Hs-lisp"
  desc: "My toy lisp and my very first language that can actually run somewhat complete programs."
  tags: ["Haskell", "Compiler/Interpreter"]
  image: "/images/lisp.png"
  action: 
    link: "https://github.com/stickyPiston/hs-lisp"
    name: "View on GitHub"
,
  name: "Nessharp"
  desc: "For the university's introductory project, we created a basic NES emulator with a group of 6 people."
  image: "/images/nessharp.png"
  tags: ["C#"]
  action:
    link: "https://github.com/stickyPiston/nessharp"
    name: "View on GitHub"
,
  name: "TI-Basic compiler"
  desc: "A compiler that translates ascii source code into ti-basic's 8xp format ready to be executed on the calculator."
  tags: ["C", "Compiler/Interpreter"]
  image: "/images/tic.png"
  action:
    link: "https://github.com/stickyPiston/ti-basic-compiler"
    name: "View on GitHub"
,
  name: "Astroids"
  desc: "My first game written in c created with just opengl. It's fair to say i had no idea what i was doing."
  tags: ["C", "OpenGL"]
  image: "/images/astroids.png"
  action:
    link: "https://github.com/stickyPiston/astroids"
    name: "View on GitHub"
,
  name: "Robotic cat"
  desc: "For a school project we decided to build a robotic cat that is <em>supposed</em> to walk like a real cat. Spoiler: it couldn't even walk at all."
  image: "/images/pws.png"
  tags: ["Arduino", "Javascript"],
,
  name: "Mandelbrot on calculator"
  desc: "For a national competition we were prompted to created something arty with a touch of maths on the graphical calculator."
  image: "/images/mandelbrot.png"
  tags: ["TI-BASIC"]
  action:
    link: "https://github.com/stickyPiston/ti-programs/tree/master/mandelbrot"
    name: "View source code"
,
  name: "Breakout"
  desc: "I recreated the retro breakout game originally made by Atari. It is broken beyond repair right now"
  image: "/images/breakout.png"
  tags: ["Typescript", "Electron"]
  action:
    link: "https://github.com/stickyPiston/breakout"
    name: "View on GitHub"
,
  name: "Heron't"
  desc: "A game that Arne and I made for a school project. It's about a person who cannot fight and needs to escape a dangerous dungeon."
  image: "/images/heront.png"
  tags: ["Typescript", "Electron"]
  action:
    link: "https://gitea.arnweb.nl/Hecc-inc./caa-game"
    name: "View on Gitea"
,
  name: "Flipbot"
  desc: "A discord bot that helps you express frustration in the form of the amazing emote (╯°□°）╯︵ ┻━┻."
  image: "/images/flipbot.png"
  tags: ["Javascript"]
  action:
    link: "https://discord.com/api/oauth2/authorize?client_id=821100693351956510&permissions=2048&scope=bot"
    name: "Invite to server"
,
  name: "Jobbel.nl"
  desc: "My website is probably one of the few web projects that are still around. Therefore, i reckon it's worth mentioning on the project page."
  image: "/images/jobbel.png"
  tags: ["Pug", "Sass", "Coffeescript"]
  action:
    link: "https://github.com/stickyPiston/website"
    name: "View source on GitHub"
,
  name: "Gymrooster"
  desc: "Simple scheduling software that allowes teachers to specify whether they teach their lessons inside or outside."
  image: "/images/gymrooster.png"
  tags: ["PHP", "HTML"]
,
  name: "HHFSRS"
  desc: "HHFSBRS is an acronym for \"Het Heerenlanden Festival Surprise Box Reserverings Systeem\". It's yet another small project for school."
  image: "/images/hhfsbrs.png"
  tags: ["Node.js", "Angular"]
,
  name: "Mediatheekrooster"
  desc: "The mediatheekrooster was a project for my school's library. There is a computer room there, and it could be scheduled."
  image: "/images/mediatheekrooster.png"
  tags: ["PHP", "MySQL", "Angular"]
,
  name: "Movement game"
  desc: "I created this game as an introduction to Unity. It is pretty basic, but it explores some key features of the game engine."
  image: "/images/movement.png"
  tags: ["Unity", "C#"]
,
  name: "Other projects on GitHub"
  desc: "Including more failed programming languages and old projects"
  image: "/images/github.png"
  action:
    link: "https://github.com/stickyPiston"
    name: "View GitHub profile"
,
  name: "Other projects on Gitea"
  desc: "The projects on Gitea are mostly collaborations with my friend Arne. Together we create some bigger projects."
  image: "/images/gitea.png"
  action:
    link: "https://gitea.arnweb.nl/corner"
    name: "View Gitea profile"
,
  name: "Cassettea"
  desc: "Cassettea is the first big project that I did with my friend Arne that turned out pretty well. Cassettea is an online music player and manager."
  image: "/images/cassettea.png"
  tags: ["Angular", "Node.js"]
]

for project in projects_en
  # Build up the card's HTML
  card = document.createElement "div"
  card.innerHTML = "
    #{"<img src=\"#{project.image}\" />" if project.image?}
    <h2>#{project.name}</h2>
    #{if project.tags
        "<div class=\"tags\">#{
          ("<span>#{tag}</span>" for tag in project.tags).join " "
        }</div>"
      else ""
    }
    <p>#{project.desc}</p>
    #{if project.action?
       "<a href=\"#{project.action.link}\">#{project.action.name or "Learn more"}</a>"
      else ""
    }
  "

  # Render the card
  document.querySelector ".list"
    .appendChild card 
