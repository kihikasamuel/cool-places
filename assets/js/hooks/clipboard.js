function copyTextFromInput() {
  // Get the text field element
  let copyText = document.getElementById("myInput");
  // Get the value of the text field
  let textToCopy = copyText.value;
  // Get the confirmation span element
  let confirmation = document.getElementById("copyConfirmation");

  // Use the Clipboard API to write the text
  navigator.clipboard.writeText(textToCopy)
    .then(() => {
      // Success: display a confirmation message
      confirmation.textContent = "Copied!";
      setTimeout(() => {
        confirmation.textContent = "";
      }, 2000); // Clear message after 2 seconds
    })
    .catch(err => {
      // Error handling
      console.error('Failed to copy text: ', err);
      confirmation.textContent = "Failed to copy.";
    });
}
