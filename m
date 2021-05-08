Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8BF37737A
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 May 2021 19:51:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E619E100EBB81;
	Sat,  8 May 2021 10:51:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3A98A100ED48C
	for <linux-nvdimm@lists.01.org>; Sat,  8 May 2021 10:51:35 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 510B660FD9;
	Sat,  8 May 2021 17:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1620496293;
	bh=O0h+6YLIy3dP7dPfFuX77EmGOJ47Y0nxessyteHlFwI=;
	h=Date:In-Reply-To:References:Subject:To:CC:From:From;
	b=BgjMRsti57RVhgQLssViPv/S1jke0ZLAX2VHcQ+zhhqyTEdCGfsx+Hm+xfLYc3gK2
	 febH6fPKLW1GSvaeOKdWLiFT7mRIPWWr75WERrbhc2iP5XTwEvaWUeT5C35mmGej+K
	 2PcdNk2F7zAnv7ool7i0GQtmQlR0QvCGCi54y4VUmuqProi5oDD31BiSBZqMLtCS+M
	 dWjPvGC1v25ePTrlu9IDnx7VhIslSf3ux2o+IJF65VRAkOiztZHjJqudkvMw1FjRre
	 H5PnmFZFJ4SyMu1vYvNmyyo21lFpuMxuRrcIpAD5pLR8VMdJxDTCRJjWYRX6B4pi1c
	 1jcXpeCGiqVyA==
Date: Sat, 08 May 2021 20:51:23 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <YJVWWFrvTzC2M0ba@casper.infradead.org>
References: <20210420150049.14031-1-rppt@kernel.org> <20210420150049.14031-3-rppt@kernel.org> <YJVWWFrvTzC2M0ba@casper.infradead.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] secretmem: optimize page_is_secretmem()
To: Matthew Wilcox <willy@infradead.org>
Message-Id: <20210508175132.510B660FD9@mail.kernel.org>
From: rppt@kernel.org
Message-ID-Hash: YPLKMGFZUAS3NXYJZY65EMKNALX3KXAF
X-Message-ID-Hash: YPLKMGFZUAS3NXYJZY65EMKNALX3KXAF
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christopher Lameter <cl@linux.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	James Bottomley <jejb@linux.ibm.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roman Gushchin <guro@fb.com>, Shakeel@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YPLKMGFZUAS3NXYJZY65EMKNALX3KXAF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

<shakeelb@google.com>,Shuah Khan <shuah@kernel.org>,Thomas Gleixner <tglx@linutronix.de>,Tycho Andersen <tycho@tycho.ws>,Will Deacon <will@kernel.org>,Yury Norov <yury.norov@gmail.com>,linux-api@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-fsdevel@vger.kernel.org,linux-mm@kvack.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-nvdimm@lists.01.org,linux-riscv@lists.infradead.org,x86@kernel.org,kernel test robot <oliver.sang@intel.com>
From: Mike Rapoport <rppt@kernel.org>
Message-ID: <48E0FD56-6084-48B0-A59C-D2E2BF40DDA2@kernel.org>



On May 7, 2021 6:01:44 PM GMT+03:00, Matthew Wilcox <willy@infradead.org> wrote:
>On Tue, Apr 20, 2021 at 06:00:49PM +0300, Mike Rapoport wrote:
>> +	mapping = (struct address_space *)
>> +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
>> +
>> +	if (mapping != page->mapping)
>> +		return false;
>> +
>> +	return page->mapping->a_ops == &secretmem_aops;
>
>... why do you go back to page->mapping here?
>
>	return mapping->a_ops == &secretmem_aops

Ok
-- 
Sincerely yours,
Mike
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
