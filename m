Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B571D1CDECF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 May 2020 17:24:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C511611818284;
	Mon, 11 May 2020 08:22:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0BB11181826D
	for <linux-nvdimm@lists.01.org>; Mon, 11 May 2020 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1589210677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+EZnNSJnLX9BN2ueYmOXehuaucuqIYsgPW/NwhW9+Q=;
	b=QRbZE0+Kinc46vYDsi45GMTCMN1suXZ2ttAd9glv9H8Xkp6fhqZHpPZSguVHD2VYTM/Qr8
	i3DmT5BMAjTpdWEkCEFHGFDTTYezIR+qHY+K153Lu/5BHLhD3rGLfxyDJgRbCJ4/wN+c/R
	rw+wmNRj6LvpQG2veJYz/3wSn8YCUyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-JMDqLkuBP2aD6tVo8BiJeQ-1; Mon, 11 May 2020 11:24:35 -0400
X-MC-Unique: JMDqLkuBP2aD6tVo8BiJeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EFB4802EAF;
	Mon, 11 May 2020 15:24:32 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-80.rdu2.redhat.com [10.10.114.80])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 871205D9DC;
	Mon, 11 May 2020 15:24:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id E86F6220C05; Mon, 11 May 2020 11:24:30 -0400 (EDT)
Date: Mon, 11 May 2020 11:24:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Message-ID: <20200511152430.GA116012@redhat.com>
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
 <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com>
 <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <CAPcyv4jvgCGU700x_U6EKyGsHwQBoPkJUF+6gP4YDPupjdViyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jvgCGU700x_U6EKyGsHwQBoPkJUF+6gP4YDPupjdViyQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: EK5UIASWCU37C5CO54VZH434EIROE4HT
X-Message-ID-Hash: EK5UIASWCU37C5CO54VZH434EIROE4HT
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linus Torvalds <torvalds@linux-foundation.org>, "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pbonzini@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EK5UIASWCU37C5CO54VZH434EIROE4HT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 06:21:45PM -0700, Dan Williams wrote:
> On Thu, Apr 30, 2020 at 5:10 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Apr 30, 2020 at 4:52 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > You had me until here. Up to this point I was grokking that Andy's
> > > "_fallible" suggestion does help explain better than "_safe", because
> > > the copy is doing extra safety checks. copy_to_user() and
> > > copy_to_user_fallible() mean *something* where copy_to_user_safe()
> > > does not.
> >
> > It's a horrible word, btw. The word doesn't actually mean what Andy
> > means it to mean. "fallible" means "can make mistakes", not "can
> > fault".
> >
> > So "fallible" is a horrible name.
> >
> > But anyway, I don't hate something like "copy_to_user_fallible()"
> > conceptually. The naming needs to be fixed, in that "user" can always
> > take a fault, so it's the _source_ that can fault, not the "user"
> > part.
> >
> > It was the "copy_safe()" model that I find unacceptable, that uses
> > _one_ name for what is at the very least *four* different operations:
> >
> >  - copy from faulting memory to user
> >
> >  - copy from faulting memory to kernel
> >
> >  - copy from kernel to faulting memory
> >
> >  - copy within faulting memory
> >
> > No way can you do that with one single function. A kernel address and
> > a user address may literally have the exact same bit representation.
> > So the user vs kernel distinction _has_ to be in the name.
> >
> > The "kernel vs faulting" doesn't necessarily have to be there from an
> > implementation standpoint, but it *should* be there, because
> >
> >  - it might affect implemmentation
> >
> >  - but even if it DOESN'T affect implementation, it should be separate
> > just from the standpoint of being self-documenting code.
> >
> > > However you lose me on this "broken nvdimm semantics" contention.
> > > There is nothing nvdimm-hardware specific about the copy_safe()
> > > implementation, zero, nada, nothing new to the error model that DRAM
> > > did not also inflict on the Linux implementation.
> >
> > Ok, so good. Let's kill this all, and just use memcpy(), and copy_to_user().
> >
> > Just make sure that the nvdimm code doesn't use invalid kernel
> > addresses or other broken poisoning.
> >
> > Problem solved.
> >
> > You can't have it both ways. Either memcpy just works, or it doesn't.
> 
> It doesn't, but copy_to_user() is frustratingly close and you can see
> in the patch that I went ahead and used copy_user_generic() to
> implement the backend of the default "fast" implementation.
> 
> However now I see that copy_user_generic() works for the wrong reason.
> It works because the exception on the source address due to poison
> looks no different than a write fault on the user address to the
> caller, it's still just a short copy. So it makes copy_to_user() work
> for the wrong reason relative to the name.
> 
> How about, following your suggestion, introduce copy_mc_to_user() (can
> just use copy_user_generic() internally) and copy_mc_to_kernel() for
> the other the helpers that the copy_to_iter() implementation needs?
> That makes it clear that no mmu-faults are expected on reads, only
> exceptions, and no protection-faults are expected at all for
> copy_mc_to_kernel() even if it happens to accidentally handle it.
> Following Jann's ex_handler_uaccess() example I could arrange for
> copy_mc_to_kernel() to use a new _ASM_EXTABLE_MC() to validate that
> the only type of exception meant to be handled is MC and warn
> otherwise?

While we are discussing this, I wanted to mention another use case
I am looking at. That is using DAX for virtiofs. virtiofs device
exports a shared memory region which guest maps using DAX. virtiofs
driver dax ops ->copy_to_iter() and ->copy_from_iter() needs to now
copy contents from/to this shared memmory region to user space.

So far we are focussed only on nvdimm and expecting only a machine
check on read side, IIUC. But this virtual device will probably
need something more.

- A page can go missing on host (because file got truncated). So error
  can happen both in read and write path.

- It might not be a machine check to report this kind of error. KVM as
  of now considering using an interrupt to report errors or possibly
  using #VE to report errors.

IOW, tying these new helpers to only machine check will work well for
nvdimm use case but not for virtual devices like virtiofs and we will
end up defining more helpers. Something more generic then machine check
might be able to address both.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
