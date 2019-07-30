Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B897B0CD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jul 2019 19:47:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3B5E6212E4B61;
	Tue, 30 Jul 2019 10:49:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3D10F212E4B5D
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 10:49:57 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jul 2019 10:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; d="scan'208";a="165942528"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga008.jf.intel.com with ESMTP; 30 Jul 2019 10:47:26 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 30 Jul 2019 10:47:26 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.180]) by
 fmsmsx121.amr.corp.intel.com ([169.254.6.243]) with mapi id 14.03.0439.000;
 Tue, 30 Jul 2019 10:47:26 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v8 07/13] daxctl: add a new reconfigure-device
 command
Thread-Topic: [ndctl PATCH v8 07/13] daxctl: add a new reconfigure-device
 command
Thread-Index: AQHVRB3wU1Qe362KGUa9cQuc9mEPUabj6s6A
Date: Tue, 30 Jul 2019 17:47:25 +0000
Message-ID: <3de8c0564d45eb4ef328a48e5ff47220335886b6.camel@intel.com>
References: <20190727015212.27092-1-vishal.l.verma@intel.com>
 <20190727015212.27092-8-vishal.l.verma@intel.com>
In-Reply-To: <20190727015212.27092-8-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <5E12955DCFF07C45A95EB4E9667ABF30@intel.com>
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
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, 2019-07-26 at 19:52 -0600, Vishal Verma wrote:
> Add a new command 'daxctl-reconfigure-device'. This is used to switch
> the mode of a dax device between regular 'device_dax' and
> 'system-memory'. The command also uses the memory hotplug sysfs
> interfaces to online the newly available memory when converting to
> 'system-ram', and to attempt to offline the memory when converting back
> to a DAX device.
> 
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/Makefile.am |   2 +
>  daxctl/builtin.h   |   1 +
>  daxctl/daxctl.c    |   1 +
>  daxctl/device.c    | 503 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 507 insertions(+)
>  create mode 100644 daxctl/device.c
> 
> +static int verify_dax_bus_model(struct daxctl_dev *dev)
> +{
> +	const char *devname = daxctl_dev_get_devname(dev);
> +	char *dev_path, *subsys_path, *resolved;
> +	struct stat sb;
> +	int rc;
> +
> +	if (asprintf(&dev_path, "/dev/%s", devname) < 0)
> +		return -ENOMEM;
> +
> +	rc = lstat(dev_path, &sb);
> +	if (rc < 0) {
> +		rc = -errno;
> +		fprintf(stderr, "%s: stat for %s failed: %s\n",
> +			devname, dev_path, strerror(-rc));
> +		goto out_dev;;
> +	}
> +
> +	if (asprintf(&subsys_path, "/sys/dev/char/%d:%d/subsystem",
> +			major(sb.st_rdev), minor(sb.st_rdev)) < 0) {
> +		rc = -ENOMEM;
> +		goto out_dev;
> +	}
> +
> +	resolved = realpath(subsys_path, NULL);
> +	if (!resolved) {
> +		rc = -errno;
> +		fprintf(stderr, "%s:  unable to determine subsys: %s\n",
> +			devname, strerror(errno));
> +		goto out_subsys;
> +	}
> +
> +	if (strcmp(resolved, "/sys/bus/dax") == 0)
> +		rc = 0;
> +	else
> +		rc = -ENXIO;
> +
> +	free(resolved);
> +out_subsys:
> +	free(subsys_path);
> +out_dev:
> +	free(dev_path);
> +	return rc;
> +}

I suspect this check is screaming to be moved into the library, and be
invoked internally by the 'enable' and 'is_enabled' routines.

When in the dax-class model, a listing of the dax device will currently
show:

{
  "chardev":"dax1.0",
  "size":799063146496,
  "target_node":3,
  "mode":"devdax",
  "state":"disabled"
}

Where the state: disabled is misleading.

I'll send a new version with this moved.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
