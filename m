Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A42698E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 May 2019 20:05:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7578521244A72;
	Wed, 22 May 2019 11:05:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EF98D212108CB
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 11:05:49 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 May 2019 11:05:48 -0700
X-ExtLoop1: 1
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by FMSMGA003.fm.intel.com with ESMTP; 22 May 2019 11:05:48 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 22 May 2019 11:05:48 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.230]) with mapi id 14.03.0415.000;
 Wed, 22 May 2019 11:05:48 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Subject: Re: [ndctl PATCH v3 00/10] daxctl: add a new reconfigure-device
 command
Thread-Topic: [ndctl PATCH v3 00/10] daxctl: add a new reconfigure-device
 command
Thread-Index: AQHVDDhtWivggYEeR02OP0UA+22Nt6Zv5+sAgAAjo4CAAADtAIAFGaEAgALIwoA=
Date: Wed, 22 May 2019 18:05:47 +0000
Message-ID: <bf9698856035cdfa24969d303f1c452ce160aa4e.camel@intel.com>
References: <20190516224053.3655-1-vishal.l.verma@intel.com>
 <CA+CK2bCEUjCNGHcfqh+4gxtf80eUkz_swNny6A2mkJwLi6Yn+Q@mail.gmail.com>
 <ff36c9ecc9073ea39b0a501d8abf5cfc48db388f.camel@intel.com>
 <CA+CK2bCtZGAjQa9OAckgoecz31xN_1iYFkUjzmLhshSa80bSFA@mail.gmail.com>
 <63ad1bacb0016bf722d038546499a6a38cc22501.camel@intel.com>
In-Reply-To: <63ad1bacb0016bf722d038546499a6a38cc22501.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <D18817E3AD27894EA4D3018D95771B8B@intel.com>
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, 2019-05-20 at 23:34 +0000, Verma, Vishal L wrote:
> On Fri, 2019-05-17 at 13:41 -0400, Pavel Tatashin wrote:
> > > Hi Pavel,
> > > 
> > > I've still not been able to hit this in my testing, is it
something
> > > you
> > > hit only after applying these patches? i.e. does plain v65 work?
> > 
> > Yes, plain v65 works, but with these patches I see this error.
> > 
> Hm, So there are only two patches that touch the add_dax_dev function:
> 
>   2bf9a8e libdaxctl: add interfaces to enable/disable devices
>   25be8f4 libdaxctl: add interfaces to get/set the online state for a
node
> 
> And of these, the second one to get the target node doesn't return an
> error in any case.
> 
> The first one can fail, so it must be that condition you're hitting,
but
> I'm not sure in what way it is failing.
> 
> The exact check is:
> 
> 	sprintf(path, "%s/modalias", daxdev_base);
> 	rc = sysfs_read_attr(ctx, path, buf);
> 	/* older kernels may be lack the modalias attribute */
> 	if (rc < 0 && rc != -ENOENT)
> 		goto err_read;
> 	if (rc == 0) {
> 		dev->kmod_list = to_module_list(ctx, buf);
> 		if (dev->kmod_list == NULL)
> 			goto err_read;

Dan points out that it might actually be the kmod portion that might be
failing. Is libkmod present in the buildroot setup, and has a depmod run
completed successfully before this point?

In any case, this incremental patch should /at least/ delay the error
until you actually try to enable a kmem device. I'll fold this into the
next version of the series.

8<----


From 2df9b6401a69833fa709ab1ad83ac27b545aeb9e Mon Sep 17 00:00:00 2001
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Wed, 22 May 2019 12:01:28 -0600
Subject: [ndctl PATCH] fixup! libdaxctl: add interfaces to
enable/disable
 devices

---
 daxctl/lib/libdaxctl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 5c85328..9d23d12 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -393,12 +393,8 @@ static void *add_dax_dev(void *parent, int id,
const char *daxdev_base)
 	/* older kernels may be lack the modalias attribute */
 	if (rc < 0 && rc != -ENOENT)
 		goto err_read;
-	if (rc == 0) {
+	if (rc == 0)
 		dev->kmod_list = to_module_list(ctx, buf);
-		if (dev->kmod_list == NULL)
-			goto err_read;
-	} else
-		dbg(ctx, "%s: modalias attribute missing\n", devname);
 
 	sprintf(path, "%s/target_node", daxdev_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
-- 
2.20.1


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
