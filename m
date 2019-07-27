Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F64677C39
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:56:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 158DC212E470A;
	Sat, 27 Jul 2019 14:58:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E8647212E259E
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:58:23 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:57 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="370587301"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:56 -0700
Subject: [ndctl PATCH v2 26/26] ndctl/monitor: Allow monitor to be manually
 moved to the background
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:41:39 -0700
Message-ID: <156426369946.531577.16184152092730982222.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Currently attempting to place the monitor into the background results in
an epoll error:

    # ndctl monitor -b nfit_test.0
    ^Z
    [1]+  Stopped                 ndctl monitor -b nfit_test.0
    # bg
    [1]+ ndctl monitor -b nfit_test.0 &
    epoll_wait error

This error is simply a wakeup from a signal EINTR, so allow the monitor
to continue assuming the signal is not fatal.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/monitor.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index 6829a6b28b58..88adf3e5d6ff 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -357,8 +357,8 @@ static int monitor_event(struct ndctl_ctx *ctx,
 	while (1) {
 		did_fail = 0;
 		nfds = epoll_wait(epollfd, events, mfa->num_dimm, -1);
-		if (nfds <= 0) {
-			err(&monitor, "epoll_wait error\n");
+		if (nfds <= 0 && errno != EINTR) {
+			err(&monitor, "epoll_wait error: (%s)\n", strerror(errno));
 			rc = -errno;
 			goto out;
 		}

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
