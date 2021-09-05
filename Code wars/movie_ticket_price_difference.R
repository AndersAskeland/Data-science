## Function that calculates when price of movie tickets becomes equal
movie <- function(card, ticket, perc) {
  ticket_total <- 0
  print(paste0(count, ": Ticket total: ", ticket_total))

  card_total <- card
  print(paste0(count, ": Card total: ", card_total))

  discount_ticket <- ticket * perc
  print(paste0(count, ": Price per ticket: ", discount_ticket))

  count <- 0

  while(ceiling(card_total) >= ceiling(ticket_total)){
    ticket_total <- ticket_total + ticket
    print(paste0(count, ": Ticket total: ", (ticket_total)))

    card_total <- card_total + discount_ticket
    print(paste0(count, ": Card total: ", (card_total)))

    discount_ticket <- discount_ticket * perc
    print(paste0(count, ": Price per ticket: ", discount_ticket))

    count <- count + 1


  }
  return(count)
}
