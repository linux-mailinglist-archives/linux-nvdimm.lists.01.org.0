Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C61685B2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 18:55:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7464310FC362B;
	Fri, 21 Feb 2020 09:56:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 254D910FC3611
	for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 09:56:14 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LHpGKk112808
	for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 12:55:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ucpft1b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 12:55:21 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Fri, 21 Feb 2020 17:55:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 17:55:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LHtEFt56623222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 17:55:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12CFDA4057;
	Fri, 21 Feb 2020 17:55:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFFD1A4053;
	Fri, 21 Feb 2020 17:55:11 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.85.88.6])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2020 17:55:11 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] monitor: Add epoll timeout for forcing a full dimm health check
Date: Fri, 21 Feb 2020 23:24:59 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022117-0016-0000-0000-000002E91094
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022117-0017-0000-0000-0000334C3201
Message-Id: <20200221175459.255556-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=957
 priorityscore=1501 clxscore=1015 suspectscore=1 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210135
Message-ID-Hash: 63DIIKNQMHHO6BLMLKVTWKPEF2ZJPIMG
X-Message-ID-Hash: 63DIIKNQMHHO6BLMLKVTWKPEF2ZJPIMG
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/63DIIKNQMHHO6BLMLKVTWKPEF2ZJPIMG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds a new command argument to the 'monitor' command namely
'--check-interval' that triggers a call to notify_dimm_event() at
regular intervals forcing a periodic check of dimm smart events.

This behavior is useful for dimms that do not support event notifications
in case the health status of an nvdimm changes. This is especially
true in case of PAPR-SCM dimms as the PHYP hyper-visor doesn't provide
any notifications to the guest kernel on a change in nvdimm health
status. In such case periodic polling of the is the only way to track
the health of a nvdimm.

The patch updates monitor_event() adding a timeout value to
epoll_wait() call. Also to prevent the possibility of a single dimm
generating enough events thereby preventing check of health status of
other nvdimms, a 'fullpoll_ts' time-stamp is added to keep track of
when full health check of all dimms happened. If after epoll_wait()
returns 'fullpoll_ts' time-stamp indicates last full dimm health check
happened beyond 'check-interval' seconds then a full dimm health check
is enforced.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 Documentation/ndctl/ndctl-monitor.txt |  4 ++++
 ndctl/monitor.c                       | 31 ++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/ndctl/ndctl-monitor.txt b/Documentation/ndctl/ndctl-monitor.txt
index 2239f047266d..14cc59d57157 100644
--- a/Documentation/ndctl/ndctl-monitor.txt
+++ b/Documentation/ndctl/ndctl-monitor.txt
@@ -108,6 +108,10 @@ will not work if "--daemon" is specified.
 The monitor will attempt to enable the alarm control bits for all
 specified events.
 
+-i::
+--check-interval=::
+	Force a recheck of dimm health every <n> seconds.
+
 -u::
 --human::
 	Output monitor notification as human friendly json format instead
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index 1755b87a5eeb..b72c5852524e 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include <json-c/json.h>
 #include <libgen.h>
+#include <time.h>
 #include <dirent.h>
 #include <util/json.h>
 #include <util/filter.h>
@@ -33,6 +34,7 @@ static struct monitor {
 	bool daemon;
 	bool human;
 	bool verbose;
+	unsigned int poll_timeout;
 	unsigned int event_flags;
 	struct log_ctx ctx;
 } monitor;
@@ -322,9 +324,14 @@ static int monitor_event(struct ndctl_ctx *ctx,
 		struct monitor_filter_arg *mfa)
 {
 	struct epoll_event ev, *events;
-	int nfds, epollfd, i, rc = 0;
+	int nfds, epollfd, i, rc = 0, polltimeout = -1;
 	struct monitor_dimm *mdimm;
 	char buf;
+	/* last time a full poll happened */
+	struct timespec fullpoll_ts, ts;
+
+	if (monitor.poll_timeout)
+		polltimeout = monitor.poll_timeout * 1000;
 
 	events = calloc(mfa->num_dimm, sizeof(struct epoll_event));
 	if (!events) {
@@ -354,14 +361,30 @@ static int monitor_event(struct ndctl_ctx *ctx,
 		}
 	}
 
+	clock_gettime(CLOCK_BOOTTIME, &fullpoll_ts);
 	while (1) {
 		did_fail = 0;
-		nfds = epoll_wait(epollfd, events, mfa->num_dimm, -1);
-		if (nfds <= 0 && errno != EINTR) {
+		nfds = epoll_wait(epollfd, events, mfa->num_dimm, polltimeout);
+		if (nfds < 0 && errno != EINTR) {
 			err(&monitor, "epoll_wait error: (%s)\n", strerror(errno));
 			rc = -errno;
 			goto out;
 		}
+
+		/* If needed force a full poll of dimm health */
+		clock_gettime(CLOCK_BOOTTIME, &ts);
+		if ((fullpoll_ts.tv_sec - ts.tv_sec) > monitor.poll_timeout) {
+			nfds = 0;
+			dbg(&monitor, "forcing a full poll\n");
+		}
+
+		/* If we timed out then fill events array with all dimms */
+		if (nfds == 0) {
+			list_for_each(&mfa->dimms, mdimm, list)
+				events[nfds++].data.ptr = mdimm;
+			fullpoll_ts = ts;
+		}
+
 		for (i = 0; i < nfds; i++) {
 			mdimm = events[i].data.ptr;
 			if (util_dimm_event_filter(mdimm, monitor.event_flags)) {
@@ -570,6 +593,8 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 				"use human friendly output formats"),
 		OPT_BOOLEAN('v', "verbose", &monitor.verbose,
 				"emit extra debug messages to log"),
+		OPT_UINTEGER('i', "check-interval", &monitor.poll_timeout,
+			     "force a dimm health recheck every <n> seconds"),
 		OPT_END(),
 	};
 	const char * const u[] = {
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
