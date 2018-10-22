const BREWERIES = {}

BREWERIES.show = () => {
  $("#brewerytable tr:gt(0)").remove()
  const table = $("#brewerytable")

  BREWERIES.list.forEach((brewery) => {
    table.append('<tr>'
      + '<td>' + brewery['name'] + '</td>'
      + '<td>' + brewery['year'] + '</td>'
      + '<td>' + brewery['beeramount'] + '</td>'
      + '<td>' + brewery['status'] + '</td>'
      + '</tr>')
  })
}

BREWERIES.sort_by_name = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  })
}

BREWERIES.sort_by_year = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year - b.year;
  })
}

BREWERIES.sort_by_beer_amount = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beeramount - b.beeramount;
  })
}

BREWERIES.sort_by_status = () => {
  BREWERIES.list.sort((a, b) => {
    return a.status.toUpperCase().localeCompare(b.status.toUpperCase());
  })
}

document.addEventListener("turbolinks:load", () => {
  if ($("#brewerytable").length == 0) {
    return
  }

  $("#name").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_name()
    BREWERIES.show(); 
  })

  $("#year").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_year()
    BREWERIES.show(); 
  })

  $("#beeramount").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_beer_amount()
    BREWERIES.show(); 
  })

  $("#status").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_status()
    BREWERIES.show(); 
  })


  $.getJSON('breweries.json', (breweries) => {
    BREWERIES.list = breweries
    BREWERIES.show()
  })
})