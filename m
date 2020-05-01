Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D01C0B35
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 02:17:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EE2A3111F36E5;
	Thu, 30 Apr 2020 17:15:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D80D8111BB865
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:15:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w2so6061781edx.4
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoAo79puf2fO2mxYjsnwa0bT+GJNCk2Wz2oE7jO1rZ0=;
        b=ai0nRHdnq5PKYZRE4Z2psZB8iAlRJQyyqODMZ0nZ/DvoxHUsUwQzU8YQzu1X4Wx3LB
         JBOdF8w1/Rq47Fp1oFb/63W9FrWFZJqfsOg0ikYPduy2VqtDflbRRqwIgmsAZQVQN8mO
         q9iAMISU0a7Og9lwvy9aWj32014T1C4JkTWFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoAo79puf2fO2mxYjsnwa0bT+GJNCk2Wz2oE7jO1rZ0=;
        b=Prgml9PwgZAvZNoaz/D6brsm0vjUQG8qeSWLc8f5bSasaZfucShq0uHdfRu2d5dww1
         29bCSGJ1EZkhc1vnmDJ223llwHHGKBbjQMC784reXc08VIEuC8ou4mk0QNWldlKkZ0T0
         iGn7KtZvaHIyzINb2382gx3KUGNu9jgC1RDdDHRnG7+jmT8FhAZ6nhMmXMdGyk+SiJhs
         wZaDL/w5U50Sxw3/iwNtOv7dwMyI/m3KNQt3YiQiWSK+XbYkpPI6Dy2GA3CxrR5fjUy5
         sRPAILd/y7yfUvbkoBclkf/JWdegx4b8NJ4AM5/fVOd0snlumTBtrZl0Mg82n4a7LK7Z
         z4tQ==
X-Gm-Message-State: AGi0PuYw6jhlzF6RFdJzjvlJ4j54gy5ZfUPHE5JL7IBiTiJuESueGKuP
	LMKs7iYsfI7BnTfKpFQ8fUtugklSV5U=
X-Google-Smtp-Source: APiQypIy5MjUmqGiSJCte+SGQBcUnuCE7YVVS+v8+6D3iCw42r6ucvK4IzLfOy6tQjeAt4kNP9m+4g==
X-Received: by 2002:a50:eb8e:: with SMTP id y14mr1461425edr.270.1588292214003;
        Thu, 30 Apr 2020 17:16:54 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id p4sm66220edm.68.2020.04.30.17.16.53
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 17:16:53 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id t12so6074764edw.3
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:16:53 -0700 (PDT)
X-Received: by 2002:a2e:3017:: with SMTP id w23mr887763ljw.150.1588291831360;
 Thu, 30 Apr 2020 17:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com> <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
 <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com>
In-Reply-To: <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Apr 2020 17:10:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
Message-ID: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 5CSTKEXSINLSX6G4NDUW464ZPO4QMBTD
X-Message-ID-Hash: 5CSTKEXSINLSX6G4NDUW464ZPO4QMBTD
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5CSTKEXSINLSX6G4NDUW464ZPO4QMBTD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 4:52 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> You had me until here. Up to this point I was grokking that Andy's
> "_fallible" suggestion does help explain better than "_safe", because
> the copy is doing extra safety checks. copy_to_user() and
> copy_to_user_fallible() mean *something* where copy_to_user_safe()
> does not.

It's a horrible word, btw. The word doesn't actually mean what Andy
means it to mean. "fallible" means "can make mistakes", not "can
fault".

So "fallible" is a horrible name.

But anyway, I don't hate something like "copy_to_user_fallible()"
conceptually. The naming needs to be fixed, in that "user" can always
take a fault, so it's the _source_ that can fault, not the "user"
part.

It was the "copy_safe()" model that I find unacceptable, that uses
_one_ name for what is at the very least *four* different operations:

 - copy from faulting memory to user

 - copy from faulting memory to kernel

 - copy from kernel to faulting memory

 - copy within faulting memory

No way can you do that with one single function. A kernel address and
a user address may literally have the exact same bit representation.
So the user vs kernel distinction _has_ to be in the name.

The "kernel vs faulting" doesn't necessarily have to be there from an
implementation standpoint, but it *should* be there, because

 - it might affect implemmentation

 - but even if it DOESN'T affect implementation, it should be separate
just from the standpoint of being self-documenting code.

> However you lose me on this "broken nvdimm semantics" contention.
> There is nothing nvdimm-hardware specific about the copy_safe()
> implementation, zero, nada, nothing new to the error model that DRAM
> did not also inflict on the Linux implementation.

Ok, so good. Let's kill this all, and just use memcpy(), and copy_to_user().

Just make sure that the nvdimm code doesn't use invalid kernel
addresses or other broken poisoning.

Problem solved.

You can't have it both ways. Either memcpy just works, or it doesn't.

So which way is it?

                  Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
