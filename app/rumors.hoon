::  rumors: anonymous messages from pals
::
::    fiction and falsehood, or a glimpse of the truth?
::    say it loudly enough for all your friends to hear!
::
/-  *rumors, webpage
/+  gossip, server,
    dbug, verb, default-agent
::
:: /~  webui  (webpage rumors rumor)  /app/rumors/webui
::
/$  grab-rumors  %noun  %rumors
::
|%
+$  state-0
  $:  %0
      fresh=rumors
      local=rumors
      stale=(set @uv)
  ==
::
+$  eyre-id  @ta
+$  card     card:agent:gall
--
::
=|  state-0
=*  state  -
::
%-  %+  agent:gossip
      [2 %leeches %leeches]
    %+  ~(put by *(map mark tube:clay))
      %rumors
    |=  =vase
    !>((grab-rumors !<(* vase)))
%-  agent:dbug
%+  verb  &
^-  agent:gall
::
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
::
++  on-init
  ^-  (quip card _this)
  :_  this
  [%pass /eyre/connect %arvo %e %connect [~ /rumors] dap.bowl]~
::
++  on-save  !>(state)
::
++  on-load
  |=  ole=vase
  ^-  (quip card _this)
  ~&  [dap.bowl %load]
  =/  old=state-0  !<(state-0 ole)
  [~ this(state old)]
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ~&  %innlel
  ?+  mark  (on-poke:def mark vase)
    ::  %rumors: transmit rumors
    ::
      %rumors
    ?>  =(our src):bowl
    :-  [(invent:gossip %rumors vase)]~
    ::TODO  sorted insert, check stale, etc
    :: this(local (weld !<(rumors vase) local))
    this
  ::
    ::  %handle-http-request: incoming from eyre
    ::
      %handle-http-request
    ::TODO  mostly copied from /app/pals... deduplicate!
    =+  !<([=eyre-id =inbound-request:eyre] vase)
    ?.  authenticated.inbound-request
      :_  this
      ::TODO  probably put a function for this into /lib/server
      ::      we can't use +require-authorization because we also update state
      %+  give-simple-payload:app:server
        eyre-id
      =-  [[307 ['location' -]~] ~]
      %^  cat  3
        '/~/login?redirect='
      url.request.inbound-request
    ::  parse request url into path and query args
    ::
    =/  ,request-line:server
      (parse-request-line:server url.request.inbound-request)
    ::
    =;  [[status=@ud out=(unit manx)] caz=(list card) =_state]
      :_  this(state state)
      %+  weld  caz
      %+  give-simple-payload:app:server
        eyre-id
      :-  [status ~]
      ?~  out  ~
      `(as-octt:mimes:html (en-xml:html u.out))
    ::  405 to all unexpected requests
    ::
    ?.  &(?=(^ site) =('rumors' i.site))
      [[500 `:/"unexpected route"] ~ state]
    ::
    =/  page=@ta
      ?~  t.site  %index
      i.t.site
    :: ?.  (~(has by webui) page)
    ::   [[404 `:/"no such page: {(trip page)}"] ~ state]
    :: =*  view  ~(. (~(got by webui) page) bowl (turn fresh.state tail))
    ::
    ::TODO  switch higher up: get never changes state!
    !!
    :: ?+  method.request.inbound-request  [[405 ~] ~ state]
    ::     %'GET'
    ::   :_  [~ state]
    ::   =-  ~!  -  -
    ::   [200 `(build:view args ~)]
    :: ::
    ::     %'POST'
    ::   ?~  body.request.inbound-request  [[400 `:/"no body!"] ~ state]
    ::   =/  args=(list [k=@t v=@t])
    ::     (rash q.u.body.request.inbound-request yquy:de-purl:html)
    ::   =/  cmd=(unit @t)
    ::     (argue:view args)
    ::   ?~  cmd
    ::     :_  [~ state]
    ::     :-  400
    ::     %-  some
    ::     ::TODO  should pass on previous inputs to re-fill fields?
    ::     %+  build:view  ^args
    ::     `|^'Something went wrong! Did you provide sane inputs?'
    ::   =^  caz  this
    ::     (on-poke %rumors !>(`rumors`[now.bowl u.cmd]~))
    ::   :_  [caz state]
    ::   :-  200
    ::   %-  some
    ::   (build:view ^args `&^'Processed succesfully.')  ::NOTE  silent?
    :: ==
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?.  =(/~/gossip/source path)
    (on-watch:def path)
  :_  this
  [%give %fact ~ %rumors !>(local)]~
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?.  ?&  =(/~/gossip/gossip wire)
          ?=(%fact -.sign)
          =(%rumors p.cage.sign)
      ==
    ~&  [dap.bowl %strange-sign wire sign]
    (on-agent:def wire sign)
  ~&  [%unpackan p.cage.sign]
  =+  !<(=rumors q.cage.sign)
  :-  ~
  |-
  ?~  rumors  this
  =/  hax=@uv  (sham i.rumors)
  ?:  (~(has in stale) hax)  $(rumors t.rumors)
  =.  stale  (~(put in stale) hax)
  !!
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ::TODO
  ::  /x/rumors
  ::  /x/rumor ? for frontend refresh button
  ~
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+  sign-arvo  (on-arvo:def wire sign-arvo)
      [%eyre %bound *]
    ~?  !accepted.sign-arvo
      [dap.bowl 'eyre bind rejected!' binding.sign-arvo]
    [~ this]
  ==
::
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--

