currentIndex = 0
buttons = Array.from document.querySelectorAll ".buttons > *"
sections = Array.from document.getElementsByTagName "article"
buttons.forEach (b, i) ->
  b.addEventListener "click", (e) ->
    oldSection = sections[currentIndex]
    newSection = sections[i]

    if i > currentIndex
      oldSection.style.top = "-100vh"
      newSection.style.top = "100vh"
    else
      oldSection.style.top = "100vh"
      newSection.style.top = "-100vh"

    buttons[currentIndex].classList.remove "active"
    buttons[i].classList.add "active"

    newSection.style.display = "grid"
    document.body.style.overflowY = "hidden"
    setTimeout (->
      newSection.style.top = "0"
      oldSection.style.display = "none"), 750
    setTimeout (-> document.body.style.overflowY = "auto"), 1750

    currentIndex = i
