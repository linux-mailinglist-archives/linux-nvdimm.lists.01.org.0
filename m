Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF32EA0C3D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 23:16:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C00820215F65;
	Wed, 28 Aug 2019 14:18:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 586DC2020D33A
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 14:18:13 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 14:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="175050360"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga008.jf.intel.com with ESMTP; 28 Aug 2019 14:16:13 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 14:16:12 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.244]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 14:16:11 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Scargall, Steve" <steve.scargall@intel.com>, "jmoyer@redhat.com"
 <jmoyer@redhat.com>
Subject: Re: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
Thread-Topic: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
Thread-Index: AQHVXduAyVJpFM+Oz0CJvO6aRKhQIqcQ/oA3gAB+yoCAAAf4AA==
Date: Wed, 28 Aug 2019 21:16:11 +0000
Message-ID: <1ac1bafeaf3253fb9396c22db334b51deb653f0a.camel@intel.com>
References: <20190828200204.21750-1-vishal.l.verma@intel.com>
 <x49y2zd6obc.fsf@segfault.boston.devel.redhat.com>
 <507921D13093A64EAF066075F3F6ED13076E485E@ORSMSX111.amr.corp.intel.com>
In-Reply-To: <507921D13093A64EAF066075F3F6ED13076E485E@ORSMSX111.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <3AF5A27AAD481D4E895A74A4E1220556@intel.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-08-28 at 13:47 -0700, Scargall, Steve wrote:
> Hi Jeff,
> 
> The issue is more of repetition.   On an 8-socket system,  should a
> user really be expected to type 'ndctl create-namespace' eight times
> vs. running 'ndctl create-namespace --region=all' once?   SAP HANA is
> an example app the requires one namespace per region.  Scripting is a
> viable solution, but that requires somebody to write the script and do
> all the error checking & handling.  Each OEM/ISV/SysAdmin would have
> their own script.  Pushing the logic to ndctl seems to be a reasonable
> approach and let the user handle any errors returned by ndctl.

A scripted solution can indeed be really simple - e.g.:

# while read -r region; do  ndctl create-namespace --region="$region";
done < <(ndctl list --bus=nfit_test.0 -R  | jq -r '.[].dev')

{
  "dev":"namespace5.0",
  "mode":"fsdax",
  "map":"dev",
  "size":"62.00 MiB (65.01 MB)",
  "uuid":"c8014457-c268-4f22-8eae-6386fbf08ceb",
  "sector_size":512,
  "align":2097152,
  "blockdev":"pmem5"
}
{
  "dev":"namespace4.0",
  "mode":"fsdax",
  "map":"dev",
  "size":"30.00 MiB (31.46 MB)",
  "uuid":"f9498ef6-cdd6-46c7-95f1-86469546ecb9",
  "sector_size":512,
  "align":2097152,
  "blockdev":"pmem4"
}

> 
> The ndctl-man-page implies the 'ndctl create-namespace --region=all'
> feature exists today:
> 
>        -r, --region=
> 
>            A regionX device name, or a region id number. The keyword
> all can be specified to carry out the operation on every region in the
> system, optionally filtered by bus id (see --bus=  option).
> 

This is true, but unfortunately, the implementation has treated create-
namespace as an exception to this since the start, and I agree with Jeff
that changing its behavior now can cause other Hyrum's law-esqe [1]
breakage.

I think however it should be easy to make a compromise, and retain the
legacy behavior of create-namespace, while creating a new create-
namespace-greedy command with the new semantics.

Thoughts on that?

Thanks,
	-Vishal

[1]: http://www.hyrumslaw.com/
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
