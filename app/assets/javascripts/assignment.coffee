class Assignment
  TEMPLATES =
    ruby: """
      describe 'the name of your test' do
        it 'should do something' do
          # write your tests here
        end
      end
    """

    javascript: """
      describe("A suite", function() {
        it("contains spec with an expectation\", function() {
          expect(true).toBe(true);
        });
      });
    """

    python: """
    import unittest

    class ExampleTestCase(unittest.TestCase):
        def test_example():
          self.assertEqual(True, True)
    """

    coffeescript: """
    describe 'something', ->

        it 'should do something', ->
            expect(true).toBe true
    """

  constructor: ->
    code_input = document.getElementById 'code'
    sample_solution = document.getElementById 'sample_solution'
    @language_selector = $ '#assignment_language'

    @editor = CodeMirror.fromTextArea code_input,
      theme: 'twilight',
      lineNumbers: true,
      styleActiveLine: true,
      matchBrackets: true

    @sample_solution = CodeMirror.fromTextArea sample_solution,
      theme: 'twilight',
      lineNumbers: true,
      styleActiveLine: true,
      matchBrackets: true

    @language_selector.on "change", @change_language

    @change_language()

  change_language: () =>
    language = @language_selector.val()

    @editor.setOption "value", TEMPLATES[language]
    @editor.setOption "mode", language

    @sample_solution.setOption "mode", language

$ ->
  new Assignment()
