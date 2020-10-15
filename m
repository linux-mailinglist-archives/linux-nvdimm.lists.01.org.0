Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D2C28EBF6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 06:13:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B3A7159D0DD6;
	Wed, 14 Oct 2020 21:13:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 242B0159D0DD5
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 21:13:17 -0700 (PDT)
IronPort-SDR: SSvRoCEYpp7tR/ebQvJ2ShO7nu+jAS0Lm36/SUChQUTFPqt7wIonNAOY4+/Y2OFlAqYOGqcKX5
 ZBTv5XBM+hZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="145561034"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400";
   d="scan'208";a="145561034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:13:17 -0700
IronPort-SDR: Rl7k8n0kXpoNoqIwrMtUpN8XayQEpRNT0hviQBpmpRIMPeasyhZ2HMFjVvFRrQMIIhpfXjPBuY
 pHwulYaXA35w==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400";
   d="scan'208";a="531099549"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:13:16 -0700
Date: Wed, 14 Oct 2020 21:13:16 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 8/9] x86/fault: Report the PKRS state on fault
Message-ID: <20201015041316.GR2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-9-ira.weiny@intel.com>
 <d6546e84-2196-25fd-3d8d-5e65fe22a71c@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6546e84-2196-25fd-3d8d-5e65fe22a71c@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: GKHEVOMDUSUIPQGBHRYWS3UTFO7XDGXB
X-Message-ID-Hash: GKHEVOMDUSUIPQGBHRYWS3UTFO7XDGXB
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GKHEVOMDUSUIPQGBHRYWS3UTFO7XDGXB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 11:56:53AM -0700, Dave Hansen wrote:
> > @@ -548,6 +549,11 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
> >  		 (error_code & X86_PF_PK)    ? "protection keys violation" :
> >  					       "permissions violation");
> >  
> > +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > +	if (irq_state && (error_code & X86_PF_PK))
> > +		pr_alert("PKRS: 0x%x\n", irq_state->pkrs);
> > +#endif
> 
> This means everyone will see 'PKRS: 0x0', even if they're on non-PKS
> hardware.  I think I'd rather have this only show PKRS when we're on
> cpu_feature_enabled(PKS) hardware.

Good catch, thanks.

> 
> ...
> > @@ -1148,14 +1156,15 @@ static int fault_in_kernel_space(unsigned long address)
> >   */
> >  static void
> >  do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
> > -		   unsigned long address)
> > +		   unsigned long address, irqentry_state_t *irq_state)
> >  {
> >  	/*
> > -	 * Protection keys exceptions only happen on user pages.  We
> > -	 * have no user pages in the kernel portion of the address
> > -	 * space, so do not expect them here.
> > +	 * If protection keys are not enabled for kernel space
> > +	 * do not expect Pkey errors here.
> >  	 */
> 
> Let's fix the double-negative:
> 
> 	/*
> 	 * PF_PK is only expected on kernel addresses whenn
> 	 * supervisor pkeys are enabled:
> 	 */

done. thanks.

> 
> > -	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SUPERVISOR_PKEYS) ||
> > +	    !cpu_feature_enabled(X86_FEATURE_PKS))
> > +		WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> 
> Yeah, please stick X86_FEATURE_PKS in disabled-features so you can use
> cpu_feature_enabled(X86_FEATURE_PKS) by itself here..

done.

thanks,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
