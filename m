Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED4C28E99F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 03:08:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2282159AD470;
	Wed, 14 Oct 2020 18:08:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50BD715943AE9
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 18:08:25 -0700 (PDT)
IronPort-SDR: +6jAcBCFyDqSM12fSwInwEKAEgW1BbkZKq0q05cQDS02BZVwV2e59pcsKsNtKSqSbq2izY7sbp
 d1r2EWMhvkaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="153166684"
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400";
   d="scan'208";a="153166684"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 18:08:25 -0700
IronPort-SDR: xRNfDck7YaZS4U7CeLu3eG8Aj2EL0jqp+Xk42HFT8CPHLPEv5vC1UNPxevHekTA57BtGk8Z5E5
 PHhaSdswy4bw==
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400";
   d="scan'208";a="531055780"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 18:08:25 -0700
Date: Wed, 14 Oct 2020 18:08:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 5/9] x86/pks: Add PKS kernel API
Message-ID: <20201015010824.GP2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-6-ira.weiny@intel.com>
 <29e9b8f1-35d6-d1d4-661d-a36fd296b593@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29e9b8f1-35d6-d1d4-661d-a36fd296b593@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 4GP3WUL6625S6NCHH7B3X4XMVURJNMWZ
X-Message-ID-Hash: 4GP3WUL6625S6NCHH7B3X4XMVURJNMWZ
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4GP3WUL6625S6NCHH7B3X4XMVURJNMWZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 11:43:57AM -0700, Dave Hansen wrote:
> > +static inline void pks_update_protection(int pkey, unsigned long protection)
> > +{
> > +	current->thread.saved_pkrs = update_pkey_val(current->thread.saved_pkrs,
> > +						     pkey, protection);
> > +	preempt_disable();
> > +	write_pkrs(current->thread.saved_pkrs);
> > +	preempt_enable();
> > +}
> 
> Why does this need preempt count manipulation in addition to the
> get/put_cpu_var() inside of write_pkrs()?

This is a bug.  The disable should be around the update_pkey_val().

> 
> > +/**
> > + * PKS access control functions
> > + *
> > + * Change the access of the domain specified by the pkey.  These are global
> > + * updates.  They only affects the current running thread.  It is undefined and
> > + * a bug for users to call this without having allocated a pkey and using it as
> > + * pkey here.
> > + *
> > + * pks_mknoaccess()
> > + *     Disable all access to the domain
> > + * pks_mkread()
> > + *     Make the domain Read only
> > + * pks_mkrdwr()
> > + *     Make the domain Read/Write
> > + *
> > + * @pkey the pkey for which the access should change.
> > + *
> > + */
> > +void pks_mknoaccess(int pkey)
> > +{
> > +	pks_update_protection(pkey, PKEY_DISABLE_ACCESS);
> > +}
> > +EXPORT_SYMBOL_GPL(pks_mknoaccess);
> 
> These are named like PTE manipulation functions, which is kinda weird.
> 
> What's wrong with: pks_disable_access(pkey) ?

Internal review suggested these names.  I'm not dead set on them.

FWIW I would rather they not get to wordy.

I was trying to get some consistency with pks_mk*() as meaning PKS 'make' X.

Do me 'disable' implies a state transition where 'make' implies we are
'setting' an absolute value.  I think the later is a better name.  And 'make'
made more sense because 'set' is so overloaded IHO.

> 
> > +void pks_mkread(int pkey)
> > +{
> > +	pks_update_protection(pkey, PKEY_DISABLE_WRITE);
> > +}
> > +EXPORT_SYMBOL_GPL(pks_mkread);
> 
> I really don't like this name.  It doesn't make readable, or even
> read-only, *especially* if it was already access-disabled.

Ok.

But it does sense if going from access-disable to read, correct?.  I could see
this being better named pks_mkreadonly() so that going from RW to this would
make more sense.  Especially after thinking about it above 'read only' needs to
be in the name.

Before I change anything I'd like to get consensus on naming.

How about the following?

pks_mk_noaccess()
pks_mk_readonly()
pks_mk_readwrite()

?

> 
> > +static const char pks_key_user0[] = "kernel";
> > +
> > +/* Store names of allocated keys for debug.  Key 0 is reserved for the kernel.  */
> > +static const char *pks_key_users[PKS_NUM_KEYS] = {
> > +	pks_key_user0
> > +};
> > +
> > +/*
> > + * Each key is represented by a bit.  Bit 0 is set for key 0 and reserved for
> > + * its use.  We use ulong for the bit operations but only 16 bits are used.
> > + */
> > +static unsigned long pks_key_allocation_map = 1 << PKS_KERN_DEFAULT_KEY;
> > +
> > +/*
> > + * pks_key_alloc - Allocate a PKS key
> > + *
> > + * @pkey_user: String stored for debugging of key exhaustion.  The caller is
> > + * responsible to maintain this memory until pks_key_free().
> > + */
> > +int pks_key_alloc(const char * const pkey_user)
> > +{
> > +	int nr;
> > +
> > +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> > +		return -EINVAL;
> 
> I'm not sure I like -EINVAL for this.  I thought we returned -ENOSPC for
> this case for user pkeys.

-ENOTSUP?

I'm not really sure anyone will need to know the difference between the
platform not supporting the key vs running out of them.  But they are 2
different error conditions.

> 
> > +	while (1) {
> > +		nr = find_first_zero_bit(&pks_key_allocation_map, PKS_NUM_KEYS);
> > +		if (nr >= PKS_NUM_KEYS) {
> > +			pr_info("Cannot allocate supervisor key for %s.\n",
> > +				pkey_user);
> > +			return -ENOSPC;

We return -ENOSPC here when running out of keys.

> > +		}
> > +		if (!test_and_set_bit_lock(nr, &pks_key_allocation_map))
> > +			break;
> > +	}
> > +
> > +	/* for debugging key exhaustion */
> > +	pks_key_users[nr] = pkey_user;
> > +
> > +	return nr;
> > +}
> > +EXPORT_SYMBOL_GPL(pks_key_alloc);
> > +
> > +/*
> > + * pks_key_free - Free a previously allocate PKS key
> > + *
> > + * @pkey: Key to be free'ed
> > + */
> > +void pks_key_free(int pkey)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> > +		return;
> > +
> > +	if (pkey >= PKS_NUM_KEYS || pkey <= PKS_KERN_DEFAULT_KEY)
> > +		return;
> 
> This seems worthy of a WARN_ON_ONCE() at least.  It's essentially
> corrupt data coming into a kernel API.

Ok, Done,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
