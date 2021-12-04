::  rumor display and entry page
::
/-  *rumors
::
|_  [=bowl:gall rumors=(list rumor)]
++  argue
  |=  [head=header-list:http body=(unit octs)]
  ^-  (unit rumor)
  ?~  body  ~
  =/  args=(map @t @t)
    %-  ~(gas by *(map @t @t))
    (fall (rush q.u.body yquy:de-purl:html) ~)
  =/  rume  (~(gut by args) 'rumor' '')
  ?:(=('' rume) ~ `[now.bowl rume])
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  manx
  ::NOTE  we would auto-close the window on-success...
  ::      except browsers don't let us, because we weren't opened by a script.
  |^  page
  ::
  ++  rumor
    %-  trip
    ?:  =(~ rumors)
      'there\'s not much going on'
    =+  ~(. og (add eny.bowl 'rumor'))
    (head (snag (rad (lent rumors)) rumors))
  ::
  ++  phrase
    %-  trip
    =+  ~(. og (add eny.bowl 'phrase'))
    (snag (rad (lent phrases)) phrases)
  ::
  ++  phrases  ^~
    ^-  (list @t)
    :~  'rumor has it...'
        'word on the street is...'
        'people have been saying...'
        'overheard on the network...'
        'did you hear?'
        'surely you don\'t believe...'
        'it\'s hard to believe, but...'
        'don\'t spread this around, but...'
    ==
  ::
  ++  prompt
    %-  trip
    =+  ~(. og (add eny.bowl 'prompt'))
    (snag (rad (lent prompts)) prompts)
  ::
  ++  prompts  ^~
    ^-  (list @t)
    :~  'what else?'
        'what\'s more?'
        'what\'s new?'
    ==
  ::
  ++  style
    '''
    * { margin: 0.2em; padding: 0.2em; font-family: sans-serif; }
    p, h2, form { max-width: 50em; text-align: center; }
    h2 { color: rgba(0,0,0,0.8); }
    form { margin: 0; padding: 0; color: rgba(0,0,0,0.8); }
    button { padding: 0.2em 0.5em; }
    .phrase { color: rgba(0,0,0,0.8); }
    '''
  ::
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"rumors"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        ;style:"{(trip style)}"
      ==
      ;body
        ;h2:"rumors and whispers"

        ;p.phrase
          {phrase}
        ==

        ;p.rumor
          {rumor}
        ==

        ;form(method "post", enctype "multipart/form-data")
          ;label
            ;+  :/"{prompt} "
            ;input(type "text", name "rumor", placeholder "...");
          ==
          ;button(type "submit"):"->"
        ==

        ;+  ?~  msg  ;p:""
            ?:  o.u.msg
              ;p.green:"{(trip t.u.msg)}"
            ;p.red:"{(trip t.u.msg)}"
      ==
    ==
  --
--
