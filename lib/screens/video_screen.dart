import 'package:flutter/material.dart';
import 'package:mistubishi_example_app/utils/download_file.dart';
import 'package:provider/provider.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  FileDownloaderProvider fileDownloaderProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fileDownloaderProvider = Provider.of<FileDownloaderProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              dowloadButton(fileDownloaderProvider),
              downloadProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget dowloadButton(FileDownloaderProvider downloaderProvider) {
    var url =
        'https://doc-0g-18-docs.googleusercontent.com/docs/securesc/37gltl1udorq7qp317rrqrk2ssvm9mg5/dfmga9202ofqnk0kif6dpbsatpkuvi3l/1608636000000/04670750326388090095/04670750326388090095/1EJq3gCttx0CGT4V03wXQkxBYnFM2QIvx?e=download&authuser=0&nonce=defiaicc37dk6&user=04670750326388090095&hash=hvq9j5834q1n';
    return new FlatButton(
      onPressed: () {
        downloaderProvider.downloadFile(url, "My File.mp3").then((onValue) {});
      },
      textColor: Colors.black,
      color: Colors.redAccent,
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        "Download File",
      ),
    );
  }

  Widget downloadProgress() {
    var fileDownloaderProvider = Provider.of<FileDownloaderProvider>(context, listen: true);

    return new Text(
      downloadStatus(fileDownloaderProvider),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  downloadStatus(FileDownloaderProvider fileDownloaderProvider) {
    var retStatus = "";

    switch (fileDownloaderProvider.downloadStatus) {
      case DownloadStatus.Downloading:
        {
          retStatus = "Download Progress : " + fileDownloaderProvider.downloadPercentage.toString() + "%";
        }
        break;
      case DownloadStatus.Completed:
        {
          retStatus = "Download Completed";
        }
        break;
      case DownloadStatus.NotStarted:
        {
          retStatus = "Click Download Button";
        }
        break;
      case DownloadStatus.Started:
        {
          retStatus = "Download Started";
        }
        break;
    }

    return retStatus;
  }
}
