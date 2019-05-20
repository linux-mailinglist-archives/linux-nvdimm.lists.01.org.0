Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4258124466
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 01:34:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B2A6212741F2;
	Mon, 20 May 2019 16:34:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8D10B212735DD
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 16:34:47 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 May 2019 16:34:46 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga008.fm.intel.com with ESMTP; 20 May 2019 16:34:46 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 20 May 2019 16:34:46 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 FMSMSX161.amr.corp.intel.com ([169.254.12.70]) with mapi id 14.03.0415.000;
 Mon, 20 May 2019 16:34:46 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Subject: Re: [ndctl PATCH v3 00/10] daxctl: add a new reconfigure-device
 command
Thread-Topic: [ndctl PATCH v3 00/10] daxctl: add a new reconfigure-device
 command
Thread-Index: AQHVDDhtWivggYEeR02OP0UA+22Nt6Zv5+sAgAAjo4CAAADtAIAFGaEA
Date: Mon, 20 May 2019 23:34:45 +0000
Message-ID: <63ad1bacb0016bf722d038546499a6a38cc22501.camel@intel.com>
References: <20190516224053.3655-1-vishal.l.verma@intel.com>
 <CA+CK2bCEUjCNGHcfqh+4gxtf80eUkz_swNny6A2mkJwLi6Yn+Q@mail.gmail.com>
 <ff36c9ecc9073ea39b0a501d8abf5cfc48db388f.camel@intel.com>
 <CA+CK2bCtZGAjQa9OAckgoecz31xN_1iYFkUjzmLhshSa80bSFA@mail.gmail.com>
In-Reply-To: <CA+CK2bCtZGAjQa9OAckgoecz31xN_1iYFkUjzmLhshSa80bSFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <BB0D3CB5A4FBE444B194B34980C14846@intel.com>
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


On Fri, 2019-05-17 at 13:41 -0400, Pavel Tatashin wrote:
> > Hi Pavel,
> > 
> > I've still not been able to hit this in my testing, is it something
> > you
> > hit only after applying these patches? i.e. does plain v65 work?
> 
> Yes, plain v65 works, but with these patches I see this error.
> 
Hm, So there are only two patches that touch the add_dax_dev function:

  2bf9a8e libdaxctl: add interfaces to enable/disable devices
  25be8f4 libdaxctl: add interfaces to get/set the online state for a node

And of these, the second one to get the target node doesn't return an
error in any case.

The first one can fail, so it must be that condition you're hitting, but
I'm not sure in what way it is failing.

The exact check is:

	sprintf(path, "%s/modalias", daxdev_base);
	rc = sysfs_read_attr(ctx, path, buf);
	/* older kernels may be lack the modalias attribute */
	if (rc < 0 && rc != -ENOENT)
		goto err_read;
	if (rc == 0) {
		dev->kmod_list = to_module_list(ctx, buf);
		if (dev->kmod_list == NULL)
			goto err_read;
	} else
		dbg(ctx, "%s: modalias attribute missing\n", devname);

Do you have the file:

  /sys/bus/dax/devices/dax0.0/modalias

And what does it contain? On my system:

  $ cat /sys/bus/dax/devices/dax0.0/modalias 
  dax:t0

If this is missing, it would seem you're not correctly in 'dax-bus'
mode, but that is kind of required for the kmem functionality anyway, so
I'm not sure where we might be tripping.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
