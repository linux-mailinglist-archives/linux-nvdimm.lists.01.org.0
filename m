Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D76F200050
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Jun 2020 04:38:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B00FD10FC5756;
	Thu, 18 Jun 2020 19:38:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4FE2E10FC5754
	for <linux-nvdimm@lists.01.org>; Thu, 18 Jun 2020 19:38:46 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J2VmrT018485;
	Thu, 18 Jun 2020 22:38:40 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31rfyt6nsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 22:38:39 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J2LbIQ012675;
	Fri, 19 Jun 2020 02:38:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03fra.de.ibm.com with ESMTP id 31r0u9gmpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2020 02:38:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05J2cZNU65274146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2020 02:38:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F1242041;
	Fri, 19 Jun 2020 02:38:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C36E44203F;
	Fri, 19 Jun 2020 02:38:32 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.74.60])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri, 19 Jun 2020 02:38:32 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 19 Jun 2020 08:08:31 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [RESEND PATCH v2] monitor: Add epoll timeout for forcing a full dimm health check
Date: Fri, 19 Jun 2020 08:08:30 +0530
Message-Id: <20200619023830.353359-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=1 phishscore=0
 cotscore=-2147483648 mlxscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190013
Message-ID-Hash: PZEWBR6OULNJPS7SULOU5VAA3E3OMYUM
X-Message-ID-Hash: PZEWBR6OULNJPS7SULOU5VAA3E3OMYUM
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PZEWBR6OULNJPS7SULOU5VAA3E3OMYUM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds a new command argument to the 'monitor' command namely
'--poll' that triggers a call to notify_dimm_event() at regular
intervals forcing a periodic check of status/events for the nvdimm
objects i.e. bus, dimms, regions or namespaces.

This behavior is useful for dimms that do not support event notifications
in case the health status of an nvdimm changes. This is especially
true in case of PAPR-SCM nvdimms as the PHYP hypervisor doesn't provide
any notifications to the guest kernel on a change in nvdimm health
status. In such case periodic polling of the is the only way to track
the health of a nvdimm.

The patch updates monitor_event() adding a timeout value to
epoll_wait() call. Also to prevent the possibility of a single dimm
generating enough events thereby preventing check for status of other
nvdimms objects, a 'fullpoll_ts' time-stamp is added to keep track of
when full check of all nvdimms objects happened. If after epoll_wait()
returns 'fullpoll_ts' time-stamp indicates last a full status check
for nvdimm objects happened beyond 'poll-interval' seconds then a full
status check is enforced.

Cc: QI Fuli <qi.fuli@jp.fujitsu.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

Resend
* None

v1..v2
* Changed the '--check-interval' arg to '--poll' [Dan Williams]
* Update the documentation and patch description of the '--poll' arg
  to accuratly reflect that it can report status/events for
  all nvdimm objects. [Dan Williams]

---
 Documentation/ndctl/ndctl-monitor.txt |  4 ++++
 ndctl/monitor.c                       | 31 ++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/ndctl/ndctl-monitor.txt b/Documentation/ndctl/ndctl-monitor.txt
index 2239f047266d..0b6bb5c416c6 100644
--- a/Documentation/ndctl/ndctl-monitor.txt
+++ b/Documentation/ndctl/ndctl-monitor.txt
@@ -108,6 +108,10 @@ will not work if "--daemon" is specified.
 The monitor will attempt to enable the alarm control bits for all
 specified events.
 
+-p::
+--poll=::
+	Poll and report status/event every <n> seconds.
+
 -u::
 --human::
 	Output monitor notification as human friendly json format instead
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index 1755b87a5eeb..4e9b2236ff3c 100644
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
+		OPT_UINTEGER('p', "poll", &monitor.poll_timeout,
+			     "poll and report events/status every <n> seconds"),
 		OPT_END(),
 	};
 	const char * const u[] = {
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
