Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED59313363
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 14:34:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 53C7E100F224B;
	Mon,  8 Feb 2021 05:34:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AAACC100F2249
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 05:34:45 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1612791284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPdxySZddbQD9qXDKMPnVWIQTa7PPiE4Qwe7qfgymrs=;
	b=Ws1lDxg/c1OUiwJ+n1TiJoYFn0hPPDdML5K4+HkUiiEWmfvzMQjPpO3/qn1jln4ONS/kQr
	iAi2I/2SSVcImlpMcLn9sGvyK1nH8qeEtezsgDdAsfxEiDnjlAtRKDe8fv4OppLwE1jcQF
	IWgpduuoLm3r0wY2pkrb6rXd+NrR404=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id EAC5AAE47;
	Mon,  8 Feb 2021 13:34:43 +0000 (UTC)
Date: Mon, 8 Feb 2021 14:34:37 +0100
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
Message-ID: <YCE97c9tDkdf+A6P@dhcp22.suse.cz>
References: <20210208084920.2884-9-rppt@kernel.org>
 <YCEP/bmqm0DsvCYN@dhcp22.suse.cz>
 <38c0cad4-ac55-28e4-81c6-4e0414f0620a@redhat.com>
 <YCEXwUYepeQvEWTf@dhcp22.suse.cz>
 <a488a0bb-def5-0249-99e2-4643787cef69@redhat.com>
 <YCEZAWOv63KYglJZ@dhcp22.suse.cz>
 <770690dc-634a-78dd-0772-3aba1a3beba8@redhat.com>
 <21f4e742-1aab-f8ba-f0e7-40faa6d6c0bb@redhat.com>
 <5db6ac46-d4e1-3c68-22a0-94f2ecde8801@redhat.com>
 <YCEr1JS8k/nDbcVR@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCEr1JS8k/nDbcVR@dhcp22.suse.cz>
Message-ID-Hash: X2DRJMUJHSRNTNKFY6L5BCJ4DCM2NBAA
X-Message-ID-Hash: X2DRJMUJHSRNTNKFY6L5BCJ4DCM2NBAA
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X2DRJMUJHSRNTNKFY6L5BCJ4DCM2NBAA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Btw. I do not see Rafael involved. Maybe he can add some insight to
this. Please note that the patch in question is
http://lkml.kernel.org/r/20210208084920.2884-9-rppt@kernel.org and
the full series is http://lkml.kernel.org/r/20210208084920.2884-1-rppt@kernel.org

On Mon 08-02-21 13:17:26, Michal Hocko wrote:
> On Mon 08-02-21 12:26:31, David Hildenbrand wrote:
> [...]
> > My F33 system happily hibernates to disk, even with an application that
> > succeeded in din doing an mlockall().
> > 
> > And it somewhat makes sense. Even my freshly-booted, idle F33 has
> > 
> > $ cat /proc/meminfo  | grep lock
> > Mlocked:            4860 kB
> > 
> > So, stopping to hibernate with mlocked memory would essentially prohibit any
> > modern Linux distro to hibernate ever.
> 
> My system seems to be completely fine without mlocked memory. It would
> be interesting to see who mlocks memory on your system and check whether
> the expectated mlock semantic really works for those. This should be
> documented at least.
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
