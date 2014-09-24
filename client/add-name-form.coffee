root = window

root.Template.addNameForm.events
  'submit form': (e, addNameTemplate) ->
    e.preventDefault()
    name = addNameTemplate.find('#nameText').value
    root.Meteor.call('insertNameData', name)
