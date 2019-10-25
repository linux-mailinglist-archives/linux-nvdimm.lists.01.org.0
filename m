Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC3E568F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 00:44:33 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67F48100EA600;
	Fri, 25 Oct 2019 15:45:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2D5E5100EEBBA
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 15:45:39 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 15:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400";
   d="scan'208";a="210863888"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 25 Oct 2019 15:44:28 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 15:44:28 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX109.amr.corp.intel.com ([169.254.15.66]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 15:44:27 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH 3/4] test/dax.sh: Validate huge page mappings
Thread-Topic: [ndctl PATCH 3/4] test/dax.sh: Validate huge page mappings
Thread-Index: AQHVhp3YA9l1C9N+nECXG4rwhhlK3qdpGYQAgAACQICAA1fbgA==
Date: Fri, 25 Oct 2019 22:44:27 +0000
Message-ID: <690e59a9ba44cefe73c8b6ce70a92c53af471364.camel@intel.com>
References: <157150317870.3940762.5638079137146963300.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <157150319417.3940762.12887432367621574807.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <77f96d5eade3b83e1ef847fd2b5533f3eb0a9cea.camel@intel.com>
	 <5e6086c2a48bce222aaedb8bb121bc64bd7fa445.camel@intel.com>
In-Reply-To: <5e6086c2a48bce222aaedb8bb121bc64bd7fa445.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <29FA4C5CF4563D4CB4B373F6062A68CB@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 3IGTFZRNVMM57ERO6I43DLSZ6KCL6LDJ
X-Message-ID-Hash: 3IGTFZRNVMM57ERO6I43DLSZ6KCL6LDJ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3IGTFZRNVMM57ERO6I43DLSZ6KCL6LDJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On Wed, 2019-10-23 at 19:33 +0000, Verma, Vishal L wrote:
> > > @@ -91,4 +111,4 @@ json=$($NDCTL create-namespace -m raw -f -e $dev)
> > >  eval $(json2var <<< "$json")
> > >  [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
> > 
> > same comment about quoting "$mode". If 'mode' happens to be empty for
> > soem reason, we want to fail with the error message - instead the above
> > will fail with a syntax error.
> 
> Sorry ignore this - that was a context line..
> 

Hey Dan,

I've applied patches 1-3, with the following fixup to patch 3.
Patch 4 didn't apply cleanly, if you can resend that I'll queue it up too.

--8<--

From 9d6c43d5240ddb18b5540b3064f2f90c25dcf574 Mon Sep 17 00:00:00 2001
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Fri, 25 Oct 2019 16:41:22 -0600
Subject: [ndctl PATCH] fixup! test/dax.sh: Validate huge page mappings

---
 test/dax.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/test/dax.sh b/test/dax.sh
index 157b398..45c2027 100755
--- a/test/dax.sh
+++ b/test/dax.sh
@@ -32,8 +32,8 @@ run_test() {
 	rc=0
 	if ! trace-cmd record -e fs_dax:dax_pmd_fault_done ./dax-pmd $MNT/$FILE; then
 		rc=$?
-		if [ $rc -ne 77 -a $rc -ne 0 ]; then
-			cleanup $1
+		if [ "$rc" -ne 77 ] && [ "$rc" -ne 0 ]; then
+			cleanup "$1"
 		fi
 	fi
 
@@ -44,17 +44,18 @@ run_test() {
 	# result of success (NOPAGE).
 	count=0
 	rc=1
-	for p in $(trace-cmd report | awk '{ print $21 }')
-	do
-		if [ $count -lt 10 ]; then
-			if [ $p != "0x100" -a $p != "NOPAGE" ]; then
-				cleanup $1
+	while read -r p; do
+		[[ $p ]] || continue
+		if [ "$count" -lt 10 ]; then
+			if [ "$p" != "0x100" ] && [ "$p" != "NOPAGE" ]; then
+				cleanup "$1"
 			fi
 		fi
 		count=$((count + 1))
-	done
+	done < <(trace-cmd report | awk '{ print $21 }')
+
 	if [ $count -lt 10 ]; then
-		cleanup $1
+		cleanup "$1"
 	fi
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
