import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lions/src/blocs/generate_pdf/save_file.dart';
import 'package:lions/src/models/club.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../models/club_response.dart';
import '../../models/region.dart';
import '../../models/zone_response.dart';
import '../../resources/repository.dart';

class pdfCreation {
  final _repository = Repository();
  createClubPdf(List<Club> apidata) async {
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
    final PdfLayoutResult result = await drawHeader(page, pageSize,
        reportName: 'District Clubs & Officers Region Wise Details report');

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

  PdfGrid getGrid(List<Club> apiData) {
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

    apiData.forEach((element) async {
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
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }

    ///this return is complesory
    return grid;
  }

  Future<PdfLayoutResult> drawHeader(PdfPage page, Size pageSize,
      {String reportName}) async {
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
        reportName, PdfStandardFont(PdfFontFamily.helvetica, 16),
        brush: PdfSolidBrush(PdfColor(255, 222, 0)),
        bounds: Rect.fromLTWH(118, 30, pageSize.width, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Invoice Number: 2058557939\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // // ignore: leading_newlines_in_multiline_strings
    // const String address = '''Bill To: \r\n\r\nAbraham Swearegin,
    //     \r\n\r\nUnited States, California, San Mateo,
    //     \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136''';

    return PdfTextElement(text: '', font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  Future<void> createRegionPdf(List<Region> apiData) async {
    isProcessing = true;
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();

    final PdfGrid grid = await getRgionGrid(apiData, pageSize);

    final PdfLayoutResult result = await drawHeader(page, pageSize,
        reportName: 'Region, Zone & Clubs Details Report');

    drawGrid(page, grid, result);

    final List<int> bytes = document.saveSync();
    document.dispose();
    await saveAndLaunchFile(bytes, 'RegionReport.pdf');
  }

  bool isProcessing = false;
  getRgionGrid(List<Region> apiData, pageSize) async {
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 4);
    grid.columns[0].width = pageSize.width / 4;
    grid.columns[1].width = pageSize.width / 4;
    grid.columns[2].width = pageSize.width / 4;
    grid.columns[3].width = pageSize.width / 4;

    for (var element in apiData) {
      final PdfGridRow row = grid.rows.add();
      final PdfGridRow row2 = grid.rows.add();
      final PdfGridRow row3 = grid.rows.add();
      row.style.font = PdfStandardFont(PdfFontFamily.helvetica, 10,
          style: PdfFontStyle.bold);
      row.cells[0].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      row.cells[0].columnSpan = 4;
      row.cells[0].style.backgroundBrush = PdfSolidBrush(PdfColor(15, 54, 156));
      row.cells[0].style.font = PdfStandardFont(PdfFontFamily.helvetica, 25);
      row.cells[0].style.textBrush = PdfBrushes.white;
      row.cells[0].stringFormat =
          PdfStringFormat(alignment: PdfTextAlignment.center);
      row.cells[0].value = element.name;
      row2.cells[0].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      row2.cells[0].columnSpan = 2;
      row2.cells[0].value =
          'Chairperson Name                 :- ${element.chairperson.name ?? ''}';
      row2.cells[2].columnSpan = 2;
      row2.cells[2].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      row2.cells[2].value =
          'Contact Number       :- ${element.chairperson.phoneNumber ?? ''}';
      row3.cells[0].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      row3.cells[0].value =
          'Email                :- ${element.chairperson.email ?? ''}';
      row3.cells[0].columnSpan = 2;
      row3.cells[2].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);

      row3.cells[2].columnSpan = 2;
      row3.cells[2].value =
          'Club                 :- ${element.chairperson.club.name ?? ''}';

      ZoneResponse response = await _repository.fetchZones(element.id);

      for (var element2 in response.results) {
        final row = grid.rows.add();
        final row2 = grid.rows.add();
        row.cells[0].columnSpan = 4;
        row.cells[0].style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
        row.style.font = PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.bold);
        row.cells[0].stringFormat =
            PdfStringFormat(alignment: PdfTextAlignment.center);
        row.cells[0].value = element2.name + '(${element.name})';
        row2.cells[0].style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
        row2.cells[0].columnSpan = 4;
        row2.style.font = PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.bold);
        row2.cells[0].stringFormat =
            PdfStringFormat(alignment: PdfTextAlignment.left);
        row2.cells[0].value = 'Clubs';

        ClubResponse clubResponse =
            await _repository.fetchClubs(element.id, element2.id);

        for (var element3 in clubResponse.results) {
          final row = grid.rows.add();
          row.style.font = PdfStandardFont(PdfFontFamily.helvetica, 10,
              style: PdfFontStyle.bold);
          row.cells[0].columnSpan = 4;
          row.cells[0].style.cellPadding =
              PdfPaddings(bottom: 5, left: 15, right: 5, top: 5);
          row.cells[0].value = element3.name;
          final row2 = grid.rows.add();
          row2.cells[0].columnSpan = 2;
          row2.cells[0].style.cellPadding =
              PdfPaddings(bottom: 5, left: 15, right: 5, top: 5);
          row2.cells[2].columnSpan = 2;
          row2.cells[2].style.cellPadding =
              PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
          row2.style.font = PdfStandardFont(PdfFontFamily.helvetica, 10,
              style: PdfFontStyle.bold);
          row2.cells[0].value = 'Officers Name ';
          row2.cells[2].value = 'Officers Number ';

          element3.members.forEach((element4) {
            final row = grid.rows.add();
            row.cells[0].style.cellPadding =
                PdfPaddings(bottom: 5, left: 15, right: 5, top: 5);
            row.cells[0].columnSpan = 2;
            row.cells[0].value = element4.name;
            row.cells[2].style.cellPadding =
                PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
            row.cells[2].columnSpan = 2;
            row.cells[2].value = element4.phoneNumber;
          });
        }
      }
    }
    // for (int i = 0; i < grid.rows.count; i++) {
    //   final PdfGridRow row = grid.rows[i];
    //   for (int j = 0; j < row.cells.count; j++) {
    //     final PdfGridCell cell = row.cells[j];
    //     cell.style.cellPadding =
    //         PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    //   }
    // }
    isProcessing = false;

    ///this return is complesory
    return grid;
  }
}
