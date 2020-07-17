Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D5223827
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 11:22:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE3A811F7AAD1;
	Fri, 17 Jul 2020 02:22:55 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE82D11F7AACD
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0cWzT9ttoeeT27mu1yXKQJtQPYAF2pim+h1ybnpSsI0=; b=tZ375G7K0Kic3bBHbECJdHyToB
	uofgKiBUdoGtRF0xWh2CTpH+grA6Ohxha9q/zMVCYJsZ31MyH13ZzHquYmLTMtFkwr1GW1OOiFznY
	9UoxGQU4GQIbjTQoPKhd0i+8kmco42C/+8qDBDHOuzLHdfOc/SUOfe/Q0SOs955+k/NuDM7mOfCvp
	2EoKAMwVL2rR+PKu16gnz/myd9zqlnSxGPYaSmlZTStTPyMlEysCRoP2w/acV4OYOOuM/HRszIVFj
	nGIjib9d+s9AkFAR84zQJKNmb+ZLvM196KiL3tpkkG3NYDtuiGcfPF3KXl8/PfVDurMcJrjstthhR
	FwwipBWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwMZn-0007Sc-TL; Fri, 17 Jul 2020 09:22:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 759913003D8;
	Fri, 17 Jul 2020 11:22:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6588829CF6F4C; Fri, 17 Jul 2020 11:22:43 +0200 (CEST)
Date: Fri, 17 Jul 2020 11:22:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V2 14/17] dax: Stray write protection for
 dax_direct_access()
Message-ID: <20200717092243.GD10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-15-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-15-ira.weiny@intel.com>
Message-ID-Hash: BUEY5A54VZYKINWRCQV2SP7VYSAWBL7P
X-Message-ID-Hash: BUEY5A54VZYKINWRCQV2SP7VYSAWBL7P
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BUEY5A54VZYKINWRCQV2SP7VYSAWBL7P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:20:53AM -0700, ira.weiny@intel.com wrote:

> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -30,12 +30,14 @@ static DEFINE_SPINLOCK(dax_host_lock);
>  
>  int dax_read_lock(void)
>  {
> +	dev_access_enable();
>  	return srcu_read_lock(&dax_srcu);
>  }
>  EXPORT_SYMBOL_GPL(dax_read_lock);
>  
>  void dax_read_unlock(int id)
>  {
> +	dev_access_disable();
>  	srcu_read_unlock(&dax_srcu, id);
>  }
>  EXPORT_SYMBOL_GPL(dax_read_unlock);

This is inconsistently ordered.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
