import { jsPDF } from "jspdf";
import html2canvas from "html2canvas";

const printToPdf = {
  mounted() {
    this.handleEvent("generate-pdf", ({ elementId, filename }) => {
      const element = document.getElementById(elementId);
      
      // Capture the element as an image first
      html2canvas(element, {
        scale: 2, // Higher quality
        useCORS: true
      }).then((canvas) => {
        const imgData = canvas.toDataURL('image/png');
        const pdf = new jsPDF('p', 'mm', 'a4');
        
        // Calculate dimensions to fit A4
        const imgProps = pdf.getImageProperties(imgData);
        const pdfWidth = pdf.internal.pageSize.getWidth();
        const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;
        
        pdf.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight);
        pdf.save(filename);
      });
    });
  }
};

export default printToPdf;