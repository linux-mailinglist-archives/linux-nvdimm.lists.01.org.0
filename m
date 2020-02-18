Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D31629FB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 17:01:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 00FA310FC338E;
	Tue, 18 Feb 2020 07:57:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 36AEF100780A1
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 07:57:06 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IFoEYq084457
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 10:53:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y6cbapkr2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 10:53:48 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Tue, 18 Feb 2020 15:53:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 18 Feb 2020 15:53:31 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01IFrUei57344126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2020 15:53:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64C8811C04A;
	Tue, 18 Feb 2020 15:53:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C21F911C054;
	Tue, 18 Feb 2020 15:53:28 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.60.35])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2020 15:53:28 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] ndctl,daxctl: Ensure allocated contexts are released before exit
Date: Tue, 18 Feb 2020 21:23:14 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20021815-0028-0000-0000-000003DC2A53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021815-0029-0000-0000-000024A13404
Message-Id: <20200218155314.89123-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_04:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=1 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxscore=0 mlxlogscore=835 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180119
Message-ID-Hash: C2J5XR4FZC6PM2URN2SZLOR62IJ7NWMZ
X-Message-ID-Hash: C2J5XR4FZC6PM2URN2SZLOR62IJ7NWMZ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C2J5XR4FZC6PM2URN2SZLOR62IJ7NWMZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Presently main_handle_internal_command() will simply call exit() on
the return value from run_builtin(). This prevents release of allocated
contexts 'struct ndctl_ctx' or 'struct daxctl_ctx' when the main
thread exits.

To fix this behavior so that allocated context are properly
deallocated, the patch updates main_handle_internal_command() removing
the call to exit() and instead storing the return value from
run_builtin() into a new out-argument to the function named
'int *out'.  Also main_handle_internal_command() now returns a boolean
value indicating if the given command was handled or not.

With the above change, daxctl/main() and ndctl/main() are updated to
pass this extra argument 'out' to main_handle_internal_command() and
handle its return value to possibly indicate an error for "Unknown
command" or exiting with the code indicated by 'out'.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 daxctl/daxctl.c | 11 +++++++----
 ndctl/ndctl.c   | 12 ++++++++----
 util/main.c     | 12 ++++++++----
 util/main.h     |  5 +++--
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index 1ab073200313..3e2b0c94002b 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -79,7 +79,7 @@ static struct cmd_struct commands[] = {
 int main(int argc, const char **argv)
 {
 	struct daxctl_ctx *ctx;
-	int rc;
+	int rc, out;
 
 	/* Look for flags.. */
 	argv++;
@@ -100,10 +100,13 @@ int main(int argc, const char **argv)
 	rc = daxctl_new(&ctx);
 	if (rc)
 		goto out;
-	main_handle_internal_command(argc, argv, ctx, commands,
-			ARRAY_SIZE(commands), PROG_DAXCTL);
+	rc = main_handle_internal_command(argc, argv, ctx, commands,
+				     ARRAY_SIZE(commands), PROG_DAXCTL, &out);
 	daxctl_unref(ctx);
-	fprintf(stderr, "Unknown command: '%s'\n", argv[0]);
+	if (!rc)
+		fprintf(stderr, "Unknown command: '%s'\n", argv[0]);
+
+	return out;
 out:
 	return 1;
 }
diff --git a/ndctl/ndctl.c b/ndctl/ndctl.c
index 6c4975c9f841..6c3a1bb339fc 100644
--- a/ndctl/ndctl.c
+++ b/ndctl/ndctl.c
@@ -112,7 +112,7 @@ static struct cmd_struct commands[] = {
 int main(int argc, const char **argv)
 {
 	struct ndctl_ctx *ctx;
-	int rc;
+	int rc, out;
 
 	/* Look for flags.. */
 	argv++;
@@ -133,10 +133,14 @@ int main(int argc, const char **argv)
 	rc = ndctl_new(&ctx);
 	if (rc)
 		goto out;
-	main_handle_internal_command(argc, argv, ctx, commands,
-			ARRAY_SIZE(commands), PROG_NDCTL);
+	rc = main_handle_internal_command(argc, argv, ctx, commands,
+					  ARRAY_SIZE(commands), PROG_NDCTL,
+					  &out);
 	ndctl_unref(ctx);
-	fprintf(stderr, "Unknown command: '%s'\n", argv[0]);
+	if (!rc)
+		fprintf(stderr, "Unknown command: '%s'\n", argv[0]);
+
+	return out;
 out:
 	return 1;
 }
diff --git a/util/main.c b/util/main.c
index 4f925f84966a..19894d86b914 100644
--- a/util/main.c
+++ b/util/main.c
@@ -121,11 +121,12 @@ out:
 	return status;
 }
 
-void main_handle_internal_command(int argc, const char **argv, void *ctx,
-		struct cmd_struct *cmds, int num_cmds, enum program prog)
+int main_handle_internal_command(int argc, const char **argv, void *ctx,
+		struct cmd_struct *cmds, int num_cmds, enum program prog,
+		int *out)
 {
 	const char *cmd = argv[0];
-	int i;
+	int i, handled = 0;
 
 	/* Turn "<binary> cmd --help" into "<binary> help cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
@@ -137,6 +138,9 @@ void main_handle_internal_command(int argc, const char **argv, void *ctx,
 		struct cmd_struct *p = cmds+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
-		exit(run_builtin(p, argc, argv, ctx, prog));
+		*out = run_builtin(p, argc, argv, ctx, prog);
+		handled = 1;
 	}
+
+	return handled;
 }
diff --git a/util/main.h b/util/main.h
index 35fb33e63049..4d4ea1dc1af7 100644
--- a/util/main.h
+++ b/util/main.h
@@ -35,8 +35,9 @@ struct cmd_struct {
 
 int main_handle_options(const char ***argv, int *argc, const char *usage_msg,
 		struct cmd_struct *cmds, int num_cmds);
-void main_handle_internal_command(int argc, const char **argv, void *ctx,
-		struct cmd_struct *cmds, int num_cmds, enum program prog);
+int main_handle_internal_command(int argc, const char **argv, void *ctx,
+		struct cmd_struct *cmds, int num_cmds, enum program prog,
+		int *out);
 int help_show_man_page(const char *cmd, const char *util_name,
 		const char *viewer);
 #endif /* __MAIN_H__ */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
