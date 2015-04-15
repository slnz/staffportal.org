Ministry.create(name: 'Student Life')
Ministry.create(name: 'Work Life')
Ministry.create(name: 'Family Life')
Ministry.create(name: 'Military Life')
Ministry.create(name: 'National Office')
Ministry.create(name: 'Athletes in Action')
Ministry.create(name: 'Love Your Neighbour')
Review::Question.create(
  text: 'Do you know what is expected of you at work?')
Review::Question.create(
  text: 'Do you have the materials, equipment and finances to do your work wel'\
  'l?')
Review::Question.create(
  text: 'At work, do you have the opportunity to do what you do best every day'\
  '?')
Review::Question.create(
  text: 'In the last seven days, have you received recognition or praise for d'\
  'oing good work?')
Review::Question.create(
  text: 'Is your leadership’s care for you as a person well communicated?')
Review::Question.create(
  text: 'Is there someone at work who encourages your development?')
Review::Question.create(
  text: 'At work, do your opinions seem to count?')
Review::Question.create(
  text: 'Do you feel your job is important to the mission of Tandem Ministries'\
  '?')
Review::Question.create(
  text: 'Are your fellow staff committed to doing quality work?')
Review::Question.create(
  text: 'Is your faith thriving within your current work environment?')
Review::Question.create(
  text: 'I am friends with the people on my team')
Review::Question.create(
  text: 'In the last six months, has someone at work talked to you about your '\
  'personal, professional and/or spiritual growth?')
Review::Question.create(
  text: ' In the last year have you had opportunities to learn and grow person'\
  'ally, professionally and spiritually?')
task = Dmpd::Taskset.create(name: '1', due_week: 42)
Dmpd::Assignment.create(name: 'As a group pray through <a target="_blank" href='\
                  '"https://docs.google.com/file/d/0B-dq1Hc0jvdBODk4QXlUb'\
                  'EtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'As a group listen to one of the <a target="_blan'\
                  'k" href="https://docs.google.com/file/d/0B-dq1Hc0jvdBM'\
                  'DZiTUFfeTZkUGM/edit">Attitude Messages</a> & continue '\
                  'to be more detailed with your notes',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Memorize one of the passages from  <a target="_b'\
                  'lank" href="https://docs.google.com/file/d/0B-dq1Hc0jv'\
                  'dBODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Review <a target="_blank" href="https://docs.goo'\
                  'gle.com/file/d/0B-dq1Hc0jvdBQzFSX3ViSHZKWUU/edit">How '\
                  'to get contacts faster than you can use them</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Call'\
                  ' Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Salv'\
                  'ation Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)

Dmpd::Assignment.create(name: 'Write your <strong>Salvation Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:text], taskset: task)
Dmpd::Assignment.create(name: 'Write your <strong>Calling Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:text], taskset: task)
Dmpd::Assignment.create(name: 'Write a Victory Story about someone receiving Ch'\
                  'rist and being transformed',
                  kind: Dmpd::Assignment.kinds[:text], taskset: task)
Dmpd::Assignment.create(name: 'Write a Victory Story about something interestin'\
                  'g from your ministry location or discipleship chain',
                  kind: Dmpd::Assignment.kinds[:text], taskset: task)

task = Dmpd::Taskset.create(name: '2', due_week: 43)
Dmpd::Assignment.create(name: 'As a group pray through <a target="_blank" href='\
                  '"https://docs.google.com/file/d/0B-dq1Hc0jvdBODk4QXlUb'\
                  'EtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'As a group listen to one of the <a target="_blan'\
                  'k" href="https://docs.google.com/file/d/0B-dq1Hc0jvdBM'\
                  'DZiTUFfeTZkUGM/edit">Attitude Messages</a> & continue '\
                  'to be more detailed with your notes',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Memorize one of the passages from <a target="_bl'\
                  'ank" href="https://docs.google.com/file/d/0B-dq1Hc0jvd'\
                  'BODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Recite the passage you memorized from the <a tar'\
                  'get="_blank" href="https://docs.google.com/file/d/0B-d'\
                  'q1Hc0jvdBODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Review <a target="_blank" href="https://docs.goo'\
                  'gle.com/file/d/0B-dq1Hc0jvdBeGJBbnJuc013YjA/edit">Non '\
                  'Negotiables of Effective MPD</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Call'\
' Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Salv'\
                  'ation Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)

Dmpd::Assignment.create(name: 'Write your <strong>Missionary Profile</strong>',
                  kind: Dmpd::Assignment.kinds[:text], taskset: task)

task = Dmpd::Taskset.create(name: '3', due_week: 44)
Dmpd::Assignment.create(name: 'As a group pray through <a target="_blank" href='\
                  '"https://docs.google.com/file/d/0B-dq1Hc0jvdBODk4QXlUb'\
                  'EtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'As a group listen to one of the <a target="_blan'\
                  'k" href="https://docs.google.com/file/d/0B-dq1Hc0jvdBM'\
                  'DZiTUFfeTZkUGM/edit">Attitude Messages</a> & continue '\
                  'to be more detailed with your notes',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Memorize one of the passages from <a target="_bl'\
                  'ank" href="https://docs.google.com/file/d/0B-dq1Hc0jvd'\
                  'BODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Recite the passage you memorized from the <a tar'\
                  'get="_blank" href="https://docs.google.com/file/d/0B-d'\
                  'q1Hc0jvdBODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Review <a target="_blank" href="https://docs.goo'\
                  'gle.com/file/d/0B-dq1Hc0jvdBWmJmTzlWQmREQTg/edit">The '\
                  'Five Main Things Needed to Get Lots of Support</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Call'\
' Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Salv'\
                  'ation Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)

task = Dmpd::Taskset.create(name: '4', due_week: 45)
Dmpd::Assignment.create(name: 'As a group pray through <a target="_blank" href='\
                  '"https://docs.google.com/file/d/0B-dq1Hc0jvdBODk4QXlUb'\
                  'EtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'As a group listen to one of the <a target="_blan'\
                  'k" href="https://docs.google.com/file/d/0B-dq1Hc0jvdBM'\
                  'DZiTUFfeTZkUGM/edit">Attitude Messages</a> & continue '\
                  'to be more detailed with your notes',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Memorize one of the passages from <a target="_bl'\
                  'ank" href="https://docs.google.com/file/d/0B-dq1Hc0jvd'\
                  'BODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Recite the passage you memorized from the <a tar'\
                  'get="_blank" href="https://docs.google.com/file/d/0B-d'\
                  'q1Hc0jvdBODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Recite <a target="_blank" href="https://docs.goo'\
                  'gle.com/file/d/0B-dq1Hc0jvdBZGhXVzJEZ2VZcTQ/edit">Our '\
                  'Teams\' Financial Need</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Recite <a target="_blank" href="https://docs.goo'\
                  'gle.com/file/d/0B-dq1Hc0jvdBdlNXMl9xNTJsa2c/edit">Tand'\
                  'em\'s Financial Policy</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Review <a target="_blank" href="https://docs.goo'\
                  'gle.com/file/d/0B-dq1Hc0jvdBYmJSRnF0S2xxazg/edit">How '\
                  'to Develop Your Ministry Partners Quickly</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Call'\
' Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Salv'\
                  'ation Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)

Dmpd::Assignment.create(name: 'Upload Your <strong>Vision Folder</strong> for y'\
                  'our coach to review. <small class="muted">5MB Max</sma'\
                  'll>',
                  kind: Dmpd::Assignment.kinds[:upload], taskset: task)

task = Dmpd::Taskset.create(name: '5', due_week: 46)
Dmpd::Assignment.create(name: 'As a group pray through <a target="_blank" href='\
                  '"https://docs.google.com/file/d/0B-dq1Hc0jvdBODk4QXlUb'\
                  'EtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'As a group listen to one of the <a target="_blan'\
                  'k" href="https://docs.google.com/file/d/0B-dq1Hc0jvdBM'\
                  'DZiTUFfeTZkUGM/edit">Attitude Messages</a> & continue '\
                  'to be more detailed with your notes',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Memorize one of the passages from <a target="_bl'\
                  'ank" href="https://docs.google.com/file/d/0B-dq1Hc0jvd'\
                  'BODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Recite the passage you memorized from the <a tar'\
                  'get="_blank" href="https://docs.google.com/file/d/0B-d'\
                  'q1Hc0jvdBODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Practice <a target="_blank" href="https://docs.g'\
                  'oogle.com/file/d/0B-dq1Hc0jvdBQUVleG80cTFnUjg/edit">Ca'\
                  'lling Blurbs</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Call'\
                  ' Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your <strong>2 Minute Salv'\
                  'ation Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)

task = Dmpd::Taskset.create(name: '6', due_week: 47)
Dmpd::Assignment.create(name: 'As a group pray through <a target="_blank" href='\
                  '"https://docs.google.com/file/d/0B-dq1Hc0jvdBODk4QXlUb'\
                  'EtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'As a group listen to one of the <a target="_bla'\
                  'nk" href="https://docs.google.com/file/d/0B-dq1Hc0jv'\
                  'dBMDZiTUFfeTZkUGM/edit">Attitude Messages</a> & conti'\
                  'nue to be more detailed with your notes',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Memorize one of the passages from <a target="_bl'\
                  'ank" href="https://docs.google.com/file/d/0B-dq1Hc0jvd'\
                  'BODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Recite the passage you memorized from the <a tar'\
                  'get="_blank" href="https://docs.google.com/file/d/0B-d'\
                  'q1Hc0jvdBODk4QXlUbEtqejA/edit">DMPD Prayer Sheet</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Practice <a target="_blank" href="https://docs.g'\
                  'oogle.com/file/d/0B-dq1Hc0jvdBQUVleG80cTFnUjg/edit">Ca'\
                  'lling Blurbs</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Practice <a target="_blank" href="https://docs.g'\
                  'oogle.com/file/d/0B-dq1Hc0jvdBM3RQVXlyMWZseXc/edit">Ap'\
                  'pointment Flow</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Review <a target="_blank" href="https://docs.goo'\
                  'gle.com/file/d/0B-dq1Hc0jvdBcWROQlREc1puMGs/edit">Heal'\
                  'thy Staff Support is Essential</a>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your '\
                  '<strong>2 Minute Call Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
Dmpd::Assignment.create(name: 'Share with your group your '\
                  '<strong>2 Minute Salvation Testimony</strong>',
                  kind: Dmpd::Assignment.kinds[:boolean], taskset: task)
