import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lions/src/blocs/generate_pdf/save_file.dart';
import 'package:lions/src/models/club.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class pdfCreation {
  bool isDownloading = false;
  createPdf(List<Club> apidata) async {
    // Create a new PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    // page.graphics.drawRectangle(
    //     bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
    //     pen: PdfPen(PdfColor(142, 170, 219)));

    //Generate PDF grid.
    final PdfGrid grid = getGrid(apidata);
    //Draw the header section by creating text element
    final PdfLayoutResult result = await drawHeader(page, pageSize, grid);

    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    // drawFooter(page, pageSize);
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'ClubsReport.pdf');
    isDownloading = true;
  }

  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    // Rect totalPriceCellBounds;
    // Rect quantityCellBounds;
    // //Invoke the beginCellLayout event.
    // grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    //   final PdfGrid grid = sender as PdfGrid;
    //   if (args.cellIndex == grid.columns.count - 1) {
    //     totalPriceCellBounds = args.bounds;
    //   } else if (args.cellIndex == grid.columns.count - 2) {
    //     quantityCellBounds = args.bounds;
    //   }
    // };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 20, 0, 0));

    //Draw grand total.
    // page.graphics.drawString('Grand Total',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 10,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(getTotalAmount(grid).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 10,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
  }

  PdfGrid getGrid(List<Club> apidata) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    // //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(2)[0];
    // //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(15, 54, 156));
    // headerRow.style.textBrush = PdfBrushes.white;
    // headerRow.cells[0].value = 'Club Name';
    //Set gird columns width
    grid.columns[0].width = 150;
    grid.columns[1].width = 120;
    grid.columns[2].width = 100;
    headerRow.cells[0].value = 'Club Name';
    headerRow.cells[1].value = 'Club Number';
    headerRow.cells[2].value = 'Region';
    headerRow.cells[3].value = 'Zone';
    headerRow.cells[4].value = 'State';

    // final PdfGridRow headerRow2 = grid2.headers.add(1)[0];
    // //Set style
    // headerRow2.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    // headerRow2.style.textBrush = PdfBrushes.white;
    // // headerRow.cells[0].value = 'Club Name';
    // headerRow2.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    // headerRow2.cells[0].value = 'Test';
    // headerRow2.cells[1].value = 'Test';
    // headerRow2.cells[2].value = 'Test';
    // headerRow2.cells[3].value = 'Test';
    // headerRow2.cells[4].value = 'Test';

    // final officers = grid2.rows.add();
    // officers.style.backgroundBrush = PdfSolidBrush(PdfColor(0, 213, 136));
    // officers.cells[0].value = 'Jay MANGUKIYA ';
    // officers.cells[1].value = 'Jay MANGUKIYA ';
    // officers.cells[2].value = 'Jay MANGUKIYA ';
    // officers.cells[3].value = 'Jay MANGUKIYA ';
    // officers.cells[4].value = 'Jay MANGUKIYA ';
    apidata.forEach((element) async {
      // addProducts(element.name, element.clubNumber, element.zone.region.name,
      //     element.zone.name, element.city.name, grid);

      final PdfGridRow row3 = grid.rows.add();
      final PdfGridRow row = grid.rows.add();
      final PdfGridRow row2 = grid.rows.add();
      row3.cells[0].value = '';
      row3.cells[1].value = '';
      row3.cells[2].value = '';
      row3.cells[3].value = '';
      row3.cells[4].value = '';
      row.style.font = PdfStandardFont(PdfFontFamily.helvetica, 10,
          style: PdfFontStyle.bold);
      row.cells[0].value = element.name;
      row.cells[1].value = element.clubNumber;
      row.cells[2].value = element.zone.region.name;
      row.cells[3].value = element.zone.name;
      row.cells[4].value = element.city.name;

      row2.cells[0].value = '';
      row2.cells[1].value = '';
      row2.cells[2].value = '';
      row2.cells[3].value = '';
      row2.cells[4].value = '';

      final officers = grid.rows.add();
      officers.style.font = PdfStandardFont(PdfFontFamily.helvetica, 10,
          style: PdfFontStyle.bold);
      officers.cells[0].value = 'Officer Name';
      officers.cells[1].value = 'Officer Club Post';
      officers.cells[2].value = 'Contact Number';

      element.members.forEach((element) {
        final officers = grid.rows.add();
        officers.cells[0].value = element.name;
        officers.cells[1].value = element.post.name;
        officers.cells[2].value = element.phoneNumber;
      });
    });
    // addProducts('AWC Logo Cap', 8.99, 2, 17.98, 'Hariyana', grid);
    // addProducts(
    //     'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, 'Maharashtra', grid);
    // addProducts('Mountain Bike Socks,M', 9.5, 2, 19, 'Goa', grid);
    // addProducts(
    //     'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, 'Maharashtra', grid);
    // addProducts('ML Fork', 175.49, 6, 1052.94, 'Gujarat', grid);
    // addProducts('Sports-100 Helmet,Black', 34.99, 1, 34.99, 'Delhi', grid);
    // addProducts('Sports-100 Helmet,Black', 34.99, 1, 34.99, 'Panjab', grid);
    // addProducts('Sports-100 Helmet,Black', 34.99, 1, 34.99, 'Rajasthan', grid);
    // addProducts('Sports-100 Helmet,Black', 34.99, 1, 34.99, 'Bihar', grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        // if (j == 0) {
        //   cell.stringFormat.alignment = PdfTextAlignment.center;
        // }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }

    ///this return is complesory
    return grid;
  }

  Future<File> memberGrid() async {}

  Future<PdfLayoutResult> drawHeader(
      PdfPage page, Size pageSize, PdfGrid grid) async {
    memberGrid();
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(15, 54, 156)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));

    final ByteData bytes = await rootBundle.load('assets/images/pdf_logo.png');
    final Uint8List list = bytes.buffer.asUint8List();

    //Create a bitmap object.
    PdfBitmap image = PdfBitmap(list);
    //Draw the image

    page.graphics.drawImage(image, Rect.fromLTWH(22, 5, 80, 80));

    //Draw string
    page.graphics.drawString(
        'Lions Digital Almanac', PdfStandardFont(PdfFontFamily.helvetica, 34),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(118, -27, pageSize.width, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawString('District 321-A2, Lions International',
        PdfStandardFont(PdfFontFamily.helvetica, 16),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(118, 5, pageSize.width, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawString(
        'District Clubs & Officers Region Wise Details report',
        PdfStandardFont(PdfFontFamily.helvetica, 16),
        brush: PdfSolidBrush(PdfColor(255, 222, 0)),
        bounds: Rect.fromLTWH(118, 30, pageSize.width, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Invoice Number: 2058557939\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    const String address = '''Bill To: \r\n\r\nAbraham Swearegin, 
        \r\n\r\nUnited States, California, San Mateo, 
        \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136''';

    return PdfTextElement(text: '', font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  void addProducts(String productName, String price, String quantity,
      String total, String state, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.style.backgroundBrush = PdfSolidBrush(PdfColor(163, 98, 169));
    row.cells[0].value = productName;
    row.cells[1].value = price.toString();
    row.cells[2].value = quantity.toString();
    row.cells[3].value = total.toString();
    row.cells[4].value = state.toString();
  }
}
