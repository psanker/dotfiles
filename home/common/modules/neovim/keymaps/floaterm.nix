{
  qnote,
  qjournal,
}: [
  {
    key = "<Leader>qn";
    action = "<CMD>FloatermNew! --cwd=~/personal/pkm ~/${qnote}<CR>";
    options.desc = "[q]uick view: open a new [n]ote in a floating term";
  }

  {
    key = "<Leader>qj";
    action = "<CMD>FloatermNew! --cwd=~/personal/pkm ~/${qjournal}<CR>";
    options.desc = "[q]uick view: open today's [j]ournal in a floating term";
  }
]
