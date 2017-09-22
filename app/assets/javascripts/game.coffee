
# Percentage of the window height used as height for the document and whiteboard
@DOCINFO_DIV_HEIGHT_PERCENTAGE = '50'

# Calculate a percentage of the window height
@windowHeightPercentage = (requiredPercentage) ->
  Math.floor($(window).height() / 100 * requiredPercentage)

# Set the height of the 'doc-data' class to a percentage of the window height
@setDocDataHeight = ->
  elements = $('.doc-data')
  e.style.height = windowHeightPercentage(DOCINFO_DIV_HEIGHT_PERCENTAGE) + 'px' for e in elements
