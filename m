Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BF528D83A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Oct 2020 04:08:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B47C13DDECFE;
	Tue, 13 Oct 2020 19:08:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 056EB13DDECFD
	for <linux-nvdimm@lists.01.org>; Tue, 13 Oct 2020 19:08:29 -0700 (PDT)
IronPort-SDR: liqseARt/HTMsN8Lo3AMFHYT+fJBtmVuQE9wrt/g4FpYbDgD6/NgsMYSMUI2I+LZlZND3o4yhu
 gSpYNKhx9LBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145335395"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400";
   d="scan'208";a="145335395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 19:08:27 -0700
IronPort-SDR: inQ4qbS0lmxsXC1fa/JBY45Zh6JLJm29uxHgtI4QzSetpkgZ6qu/XIxzj094gWeTQWPgLeSmUk
 brKTQAX3Hb1w==
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400";
   d="scan'208";a="530644675"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 19:08:26 -0700
Date: Tue, 13 Oct 2020 19:08:25 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 3/9] x86/pks: Enable Protection Keys Supervisor
 (PKS)
Message-ID: <20201014020825.GM2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-4-ira.weiny@intel.com>
 <cfd8e361-9d5b-5b24-08d4-31ad3d392255@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cfd8e361-9d5b-5b24-08d4-31ad3d392255@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: IQOB2KQMBCJEN3ZINNB4IH7GUNHRMZ4K
X-Message-ID-Hash: IQOB2KQMBCJEN3ZINNB4IH7GUNHRMZ4K
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IQOB2KQMBCJEN3ZINNB4IH7GUNHRMZ4K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 11:23:08AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > +/*
> > + * PKS is independent of PKU and either or both may be supported on a CPU.
> > + * Configure PKS if the cpu supports the feature.
> > + */
> 
> Let's at least be consistent about CPU vs. cpu in a single comment. :)

Sorry, done.

> 
> > +static void setup_pks(void)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SUPERVISOR_PKEYS))
> > +		return;
> > +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> > +		return;
> 
> If you put X86_FEATURE_PKS in disabled-features.h, you can get rid of
> the explicit CONFIG_ check.

Done.

> 
> > +	cr4_set_bits(X86_CR4_PKS);
> > +}
> > +
> >  /*
> >   * This does the hard work of actually picking apart the CPU stuff...
> >   */
> > @@ -1544,6 +1558,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> >  
> >  	x86_init_rdrand(c);
> >  	setup_pku(c);
> > +	setup_pks();
> >  
> >  	/*
> >  	 * Clear/Set all flags overridden by options, need do it
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 6c974888f86f..1b9bc004d9bc 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -822,6 +822,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
> >  	bool
> >  config ARCH_HAS_PKEYS
> >  	bool
> > +config ARCH_HAS_SUPERVISOR_PKEYS
> > +	bool
> >  
> >  config PERCPU_STATS
> >  	bool "Collect percpu memory statistics"
> > 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
