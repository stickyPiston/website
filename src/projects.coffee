window.projects = () ->
  projects_en = [
    name: "Hs-lisp",
    desc: "My toy lisp and my very first language that can actually run somwhat complete programs.",
    action: 
      link: "https://github.com/stickyPiston/hs-lisp",
      name: "View on GitHub"
  ,
    name: "TI-Basic compiler",
    desc: "A compiler that translates ascii source code into ti-basic's 8xp format ready to be executed on the calculator.",
    action:
      link: "https://github.com/stickyPiston/ti-basic-compiler"
      name: "View on GitHub"
  ,
    name: "Astroids",
    desc: "My first game written in c created with just opengl. It's fair to say i had no idea what i was doing.",
    action:
      link: "https://github.com/stickyPiston/astroids",
      name: "View on GitHub"
  ]
  
  for project in projects_en
    # Build up the card's HTML
    card = document.createElement "div"
    card.innerHTML = "
      <h2>#{project.name}</h2>
      <p>#{project.desc}</p>
    "
    if project.action?
      card.innerHTML += 
        "<a href=\"#{project.action.link}\">#{project.action.name || "Learn more"}</a>"

    # Render the card
    document.querySelector ".list"
      .appendChild card 
