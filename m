Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2394F2EB
	for <lists+linux-nvdimm@lfdr.de>; Sat, 22 Jun 2019 02:54:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5DEBC212A36CD;
	Fri, 21 Jun 2019 17:54:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B847B2125ADC5
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 17:54:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l19so4126759pgh.9
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 17:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pn4/IgcE/a3A9HRsf8YysVQmDOFkLMRirlv4eJOCAEY=;
 b=r0d0D49hNJck2jmBOZ7hKq1EyIQm5VIsrCLXNfWA/zqw7JUB/PFT9/TEg3f9m8Exka
 4OB4CLnAA+t7ZyRfMqNWActJqwB4eElCzw9OwOGul12RrF6Xah0/adQB3rDPYCiKwGSb
 1cQfwLiJupuJHVE6kDeqU7eCLKZrrozRyUdaq1BAJ5w/IyIufGa6roBqLtZxSQ3wQLl8
 cBD+npmSvsH7CB96WJOcXSzHxVdpszLog3BtkM+9yhp75ZfrhE2bcktgSWTAXvuCSrTY
 kUvb5BfS0a52N4OmjgywAeDaICRhfTcMxYZ0cxZGqUP9umwcIynczzP5GVJDJnjw5aRm
 2oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pn4/IgcE/a3A9HRsf8YysVQmDOFkLMRirlv4eJOCAEY=;
 b=ZULmcxGPHoTSgruVJqkMAPKZ93tGe5OoyEFRG1ogHuudsz4Iw+uRNutNNKVqgIwiPa
 9s2JqrGseneb+N2C06+H67xt+CAz6jP7h7Dq7YZYJDNSqxYXkybynTWHlZwNHYksUC/9
 dUQJYjYwIZJFqo4QXpRwkTBhqIrHH+yNuFklE8O6ZzcyM1Ptu1ddDL8jCX8Ent7Q/S6c
 l9jgvpUVyHwJZQjYchjv964yWO68sxVAipCjjOQ3N1XwpvgRl11JcSMFcFTRn7mQ2hOX
 4RsaHLr8ZetRp0DYsu4rygt6zAZhgeftY9INFMfEHOuiwzbVQyhkPvCDpqc3K9jsmMLk
 favw==
X-Gm-Message-State: APjAAAVSUoPq3bFtGASQfOwzncfQcGI9BBTObzy2Bw6SkqnrjT0MTWeB
 UTc5Ry5ALsOzc2je3acv2w99aUtsZViGSAmS2urWAg==
X-Google-Smtp-Source: APXvYqwOxize9xmrZ2ApT7No74w3onQmjRsjgozaiDJFMKpG33Vqht+PxeXD1e0v4vbFE+q+E/bORwyHwGlVO6g99RY=
X-Received: by 2002:a17:90a:9382:: with SMTP id
 q2mr10190000pjo.131.1561164883594; 
 Fri, 21 Jun 2019 17:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
 <69809117-dcda-160a-ee0a-d1d3b4c5cd8a@kernel.org>
 <20190621181342.GA17166@mit.edu>
 <6f3f5184-d14e-1b46-17f1-391ee67e699c@kernel.org>
In-Reply-To: <6f3f5184-d14e-1b46-17f1-391ee67e699c@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 21 Jun 2019 17:54:31 -0700
Message-ID: <CAFd5g46W1u+6JKLW0WX9uicK5utvJe9tvq4YBsCkghuo0rCmng@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: shuah <shuah@kernel.org>
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
Cc: Petr Mladek <pmladek@suse.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 21, 2019 at 12:21 PM shuah <shuah@kernel.org> wrote:
>
> On 6/21/19 12:13 PM, Theodore Ts'o wrote:
> > On Fri, Jun 21, 2019 at 08:59:48AM -0600, shuah wrote:
> >>>> ### But wait! Doesn't kselftest support in kernel testing?!
> >>>>
> >>>> ....
> >>
> >> I think I commented on this before. I agree with the statement that
> >> there is no overlap between Kselftest and KUnit. I would like see this
> >> removed. Kselftest module support supports use-cases KUnit won't be able
> >> to. I can build an kernel with Kselftest test modules and use it in the
> >> filed to load and run tests if I need to debug a problem and get data
> >> from a system. I can't do that with KUnit.

Sure, I think this point has been brought up a number of times before.
Maybe I didn't write this section well because, like Frank said, it
comes across as being critical of the Kselftest module support; that
wasn't my intention. I was speaking from the perspective that
Kselftest module support is just a feature of Kselftest, and not a
full framework like KUnit is (obviously Kselftest itself *is* a
framework, but a very small part of it is not).

It was obvious to me what Kselftest module support was intended for,
and it is not intended to cover the use case that KUnit is targeting.

> >> In my mind, I am not viewing this as which is better. Kselftest and
> >> KUnit both have their place in the kernel development process. It isn't
> >> productive and/or necessary to comparing Kselftest and KUnit without a
> >> good understanding of the problem spaces for each of these.

Again, I didn't mean to draw a comparison of which is better than the
other. I was just trying to point out that Kselftest module support
doesn't make sense as a stand alone unit testing framework, or really
a framework of any kind, despite how it might actually be used.

> >> I would strongly recommend not making reference to Kselftest and talk
> >> about what KUnit offers.

I can see your point. It seems that both you and Frank seem to think
that I drew a comparison between Kselftest and KUnit, which was
unintended. I probably should have spent more time editing this
section, but I can see the point of drawing the comparison itself
might invite this confusion.

> > Shuah,
> >
> > Just to recall the history, this section of the FAQ was added to rebut
> > the ***very*** strong statements that Frank made that there was
> > overlap between Kselftest and Kunit, and that having too many ways for
> > kernel developers to do the identical thing was harmful (he said it
> > was too much of a burden on a kernel developer) --- and this was an
> > argument for not including Kunit in the upstream kernel.

I don't think he was actually advocating that we don't include KUnit,
maybe playing devil's advocate; nevertheless, at the end, Frank seemed
to agree that there were valuable things that KUnit offered. I thought
he just wanted to make the point that I hadn't made the distinction
sufficiently clear in the cover letter, and other reviewers might get
confused in the future as well.

Additionally, it does look like people were trying to use Kselftest
module support to cover some things which really were trying to be
unit tests. I know this isn't really intended - everything looks like
a nail when you only have a hammer, which I think Frank was pointing
out furthers the above confusion.

In anycase, it sounds like I have, if anything, only made the
discussion even more confusing by adding this section; sorry about
that.

> > If we're past that objection, then perhaps this section can be
> > dropped, but there's a very good reason why it was there.  I wouldn't
> > Brendan to be accused of ignoring feedback from those who reviewed his
> > patches.   :-)
> >
>
> Agreed. I understand that this FAQ probably was needed at one time and
> Brendan added it to address the concerns.

I don't want to speak for Frank, but I don't think it was an objection
to KUnit itself, but rather an objection to not sufficiently
addressing the point about how they differ.

> I think at some point we do need to have a document that outlines when
> to KUnit and when to use Kselftest modules. I think one concern people
> have is that if KUnit is perceived as a  replacement for Ksefltest
> module, Kselftest module will be ignored leaving users without the
> ability to build and run with Kselftest modules and load them on a need
> basis to gather data on a systems that aren't dedicated strictly for
> testing.

I absolutely agree! I posed a suggestion here[1], which after I just
now searched for a link, I realize for some reason it didn't seem like
it reached a number of the mailing lists that I sent it to, so I
should probably resend it.

Anyway, a summary of what I suggested: We should start off by better
organizing Documentation/dev-tools/ and create a landing page that
groups the dev-tools by function according to what person is likely to
use them and for what. Eventually and specifically for Kselftest and
KUnit, I would like to have a testing guide for the kernel that
explains what testing procedure should look like and what to use and
when.

> I am trying to move the conversation forward from KUnit vs. Kselftest
> modules discussion to which problem areas each one addresses keeping
> in mind that it is not about which is better. Kselftest and KUnit both
> have their place in the kernel development process. We just have to be
> clear on usage as we write tests for each.

I think that is the right long term approach. I think a good place to
start, like I suggested above, is cleaning up
Documentation/dev-tools/, but I think that belongs in a (probably
several) follow-up patchset.

Frank, I believe your objection was mostly related to how KUnit is
presented specifically in the cover letter, and doesn't necessarily
deal with the intended use case. So I don't think that doing this,
especially doing this later, really addresses your concern. I don't
want to belabor the issue, but I would also rather not put words in
your mouth, what are your thoughts on the above?

I think my main concern moving forward on this point is that I am not
sure that I can address the debate that this section covers in a way
that is both sufficiently concise for a cover letter, but also doesn't
invite more potential confusion. My inclination at this point is to
drop it since I think the set of reviewers for this patchset has at
this point become fixed, and it seems that it will likely cause more
confusion rather than reduce it; also, I don't really think this will
be an issue for end users, especially once we have proper
documentation in place. Alternatively, I guess I could maybe address
the point elsewhere and refer to it in the cover letter? Or maybe just
put it at the end of the cover letter?

[1] https://www.mail-archive.com/kgdb-bugreport@lists.sourceforge.net/msg05059.html
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
