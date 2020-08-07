Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 468BB23E7A6
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Aug 2020 09:17:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CDEE12C2F65A;
	Fri,  7 Aug 2020 00:17:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=rong.a.chen@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53B5D12C2F656;
	Fri,  7 Aug 2020 00:17:25 -0700 (PDT)
IronPort-SDR: bpN3xgxF38dopFc++KLUA0r9RDCAIJ27NUTz5dzaADVhGKvKB4L6I+UYpEGHvxkp6O4Ou2CQDT
 AkTylQJp+43w==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="132580744"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800";
   d="scan'208";a="132580744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 00:17:24 -0700
IronPort-SDR: TW2/Rs+oqVNyglT8SzPM1QCZ+r337k9xEfMIf6xTm3CR693d7jRwYZJWOfJqpBWRiswXg1Gb0R
 FKA72pWheM4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800";
   d="scan'208";a="289534895"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2020 00:17:20 -0700
Date: Fri, 7 Aug 2020 15:16:43 +0800
From: kernel test robot <rong.a.chen@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [x86/copy_mc] a0ac629ebe: fio.read_iops -43.3% regression
Message-ID: <20200807071643.GL23458@shao2-debian>
References: <159630256804.3143511.8894023468833792004.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200803094257.GA23458@shao2-debian>
 <20200806133452.GA2077191@gmail.com>
 <CAPcyv4hS7K0Arrd+C0LhjrFH=yGJf3g55_WkHOET4z58AcWrJw@mail.gmail.com>
 <20200806153500.GC2131635@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806153500.GC2131635@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: AO32IRVXF4I4U4NKIFTVAVDUM7JD5QHD
X-Message-ID-Hash: AO32IRVXF4I4U4NKIFTVAVDUM7JD5QHD
X-MailFrom: rong.a.chen@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 0day robot <lkp@intel.com>, lkp@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AO32IRVXF4I4U4NKIFTVAVDUM7JD5QHD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 06, 2020 at 05:35:00PM +0200, Ingo Molnar wrote:
> 
> * Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Thu, Aug 6, 2020 at 6:35 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * kernel test robot <rong.a.chen@intel.com> wrote:
> > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed a -43.3% regression of fio.read_iops due to commit:
> > > >
> > > >
> > > > commit: a0ac629ebe7b3d248cb93807782a00d9142fdb98 ("x86/copy_mc: Introduce copy_mc_generic()")
> > > > url: https://github.com/0day-ci/linux/commits/Dan-Williams/Renovate-memcpy_mcsafe-with-copy_mc_to_-user-kernel/20200802-014046
> > > >
> > > >
> > > > in testcase: fio-basic
> > > > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
> > > > with following parameters:
> > >
> > > So this performance regression, if it isn't a spurious result, looks
> > > concerning. Is this expected?
> > 
> > This is not expected and I think delays these patches until I'm back
> > from leave in a few weeks. I know that we might lose some inlining
> > effect due to replacing native memcpy, but I did not expect it would
> > have an impact like this. In my testing I was seeing a performance
> > improvement from replacing the careful / open-coded copy with rep;
> > mov;, which increases the surprise of this result.
> 
> It would be nice to double check this on the kernel-test-robot side as 
> well, to make sure it's not a false positive.
> 

Hi Ingo,

We recompiled the kernels with option "-falign-functions=32", and the
regression still exists:

7476b91d4db369d8  a0ac629ebe7b3d248cb9380778  testcase/testparams/testbox
----------------  --------------------------  ---------------------------
         %stddev      change         %stddev
             \          |                \  
     22103             -43%      12551        fio-basic/2M-performance-2pmem-xfs-libaio-dax-50%-200s-read-200G-tb-ucode=0x5002f01/lkp-csl-2sp6
     22103             -43%      12551        GEO-MEAN fio.read_iops

Best Regards,
Rong Chen
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
