Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC1CC5CC
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Oct 2019 00:27:24 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A28D10097F3C;
	Fri,  4 Oct 2019 15:28:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com; envelope-from=brendanhiggins@google.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69A5510097F3C
	for <linux-nvdimm@lists.01.org>; Fri,  4 Oct 2019 15:28:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v27so4512131pgk.10
        for <linux-nvdimm@lists.01.org>; Fri, 04 Oct 2019 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sGtC9Y61I0fWewzKpxnAs5yLawr9FrkTbXzFkx6uKAk=;
        b=YeeGuXR/EbMstIHwMR+WBpofOCJlBn7xcT75NgBfyAZoiHg/V1PWHpO2epGkRD81Ai
         4RW+gTAEC4WD2yQ2SDrd5K9D7fdDNSPo3UNYUZZ8Zf+ibkFAmTJbDVSYEarDpJ5oPg1j
         dg3dC2LmBlg/HcrMgqb9PfzfTOzDXYHOa+/PYROjQTT8qZENzhrzuulgnZ3jTVdd9CoS
         6vHXpukys6F6ZvGyvO/MC52uvNRRW1RrRmLnirND7BrQ4tM7+hSt8ILrukDjy2Zkorp5
         a2EePtRfrlsKmCyDjJa9T4B+oNHxvnazyX654xQc9H1YU9WC6Z9K9EsF5+8bMHzSZibS
         tMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGtC9Y61I0fWewzKpxnAs5yLawr9FrkTbXzFkx6uKAk=;
        b=UDqaULFZSyEwhdkBgEF3pOME/ycQUZivlH/RCvMYicrfZ2f3stern8JkrU4ZfDTwkt
         0EM3bqxuAFFjbVnut1mvYz/UxKaV1mks/i8EP088XgYd1ZO/fIMzAMKLQtwm5PhAnQPB
         IaKwDSHcvcoJyMYKBnJMPcgzk0V3ArrgeyR1RuqTnwALXc9M/FhR/jxcJJ8xaMYaaQTZ
         +DJgdQJ/24aK3MwqsNgPxsO6sfT2+JrTIM/+5XY9W+DbqWT4I90dG3SArZ3H2kPHMNZR
         y+dJTFcobwah7NsxrLyOr1lycLAGWDgJ1e/Cb4RtvnAsfzSJ/3CzuGgnyPBfbneFzDWm
         sRgg==
X-Gm-Message-State: APjAAAVmDuItWIfU6cPdpLfygkq/GV+erOVfK+UV+3Q0C6MpskdrTGIz
	NCAwSmNM37/V/Vq/iG6JRot4CQ==
X-Google-Smtp-Source: APXvYqz9/Um6buAfhCtRCPjLYgne6gcH8Y83qWem0TWomrvMdMPDQueWyrF35KAweIvctX7qICTVOw==
X-Received: by 2002:a65:638a:: with SMTP id h10mr8380897pgv.106.1570228039982;
        Fri, 04 Oct 2019 15:27:19 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id w7sm5066788pjn.1.2019.10.04.15.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 15:27:19 -0700 (PDT)
Date: Fri, 4 Oct 2019 15:27:14 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: shuah <shuah@kernel.org>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20191004222714.GA107737@google.com>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu>
 <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: XSHEJWDTBWNZUR4AREDFHBFLZS7JKFTJ
X-Message-ID-Hash: XSHEJWDTBWNZUR4AREDFHBFLZS7JKFTJ
X-MailFrom: brendanhiggins@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, kieran.bingham@ideasonboard.com, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, robh@kernel.org, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin <Alexander.Levin@microsoft.com>, Tim.Bird@sony.com, Amir Goldstein
  <amir73il@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, khilman@baylibre.com, knut.omang@oracle.com, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XSHEJWDTBWNZUR4AREDFHBFLZS7JKFTJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 04, 2019 at 03:59:10PM -0600, shuah wrote:
> On 10/4/19 3:42 PM, Linus Torvalds wrote:
> > On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > > 
> > > This question is primarily directed at Shuah and Linus....
> > > 
> > > What's the current status of the kunit series now that Brendan has
> > > moved it out of the top-level kunit directory as Linus has requested?
> > 
> 
> The move happened smack in the middle of merge window and landed in
> linux-next towards the end of the merge window.
> 
> > We seemed to decide to just wait for 5.5, but there is nothing that
> > looks to block that. And I encouraged Shuah to find more kunit cases
> > for when it _does_ get merged.
> > 
> 
> Right. I communicated that to Brendan that we could work on adding more
> kunit based tests which would help get more mileage on the kunit.
> 
> > So if the kunit branch is stable, and people want to start using it
> > for their unit tests, then I think that would be a good idea, and then
> > during the 5.5 merge window we'll not just get the infrastructure,
> > we'll get a few more users too and not just examples.

I was planning on holding off on accepting more tests/changes until
KUnit is in torvalds/master. As much as I would like to go around
promoting it, I don't really want to promote too much complexity in a
non-upstream branch before getting it upstream because I don't want to
risk adding something that might cause it to get rejected again.

To be clear, I can understand from your perspective why getting more
tests/usage before accepting it is a good thing. The more people that
play around with it, the more likely that someone will find an issue
with it, and more likely that what is accepted into torvalds/master is
of high quality.

However, if I encourage arbitrary tests/improvements into my KUnit
branch, it further diverges away from torvalds/master, and is more
likely that there will be a merge conflict or issue that is not related
to the core KUnit changes that will cause the whole thing to be
rejected again in v5.5.

I don't know. I guess we could maybe address that situation by splitting
up the pull request into features and tests when we go to send it in,
but that seems to invite a lot of unnecessary complexity. I actually
already had some other tests/changes ready to send for review, but was
holding off until the initial set of patches mad it in.

Looking forward to hearing other people's thoughts.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
