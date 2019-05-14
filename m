Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED11CEA0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 20:08:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C07AB2127544B;
	Tue, 14 May 2019 11:08:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 316E72125F1D1
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 11:08:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w22so9009708pgi.6
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7yeeHOrqmC8a3wbdrT1dAENCvxmyZ37Vuhxj9vZ+GQw=;
 b=S0jZM4XE6V0spZEZFXmF3lzmN9RyUrDls3YW1YfceLrf1+atDdYu1cDy9C4umcia/3
 zscYDmEM5QFhJ0Lva8Sr/fBO7umd8310R/E4POlAM5wiB7jMzgSkP8SsOgHo4cuPtzqM
 j5f31ImygRcFRnpQwdS5IZIz9c6qvCbiaaZwXxiQnGCs4OmdaNEeAT0BXUQnQH/qgAa6
 HfIIFTZyV9zShckZnWJw1oElQyqVHLhJcgWa8zt0ufYs+8dsKUPv2sW1yVTo4jhRi601
 xWiCimgXoAgU8fIvE1m4CgoqiIh5RUVt2mEcjUAPFJsbkkmefrie+e0G224VchBEu3Gt
 Tibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7yeeHOrqmC8a3wbdrT1dAENCvxmyZ37Vuhxj9vZ+GQw=;
 b=CYbx3juDWaLEqje+Mm5KkplHOVF2P6qOy7B+mPzJEe6O3MXmYvXFp4TK5jgVzv6qgh
 ZcuX66qBfuRDvl5WXizv1NEBsHTx/JpYLMv6vs+GnQWZRTCPdflp1W/pOJzf9DehjdX8
 gH5R+ojiiwKV83OT3h+O1qDCTtI7TNCsQr3puzwHy5omkaFb1suR1yhjtfqbewEAFfBG
 gFdwbp463pg1SO/x743/dFseVAHsbzlJjdclX7E+FCelIRBeOq65Al3k5OOF+2yzQAwE
 JkRXqAltZIVqCD+MAtjlrGOEkPdjQHOllg3IvgSkhrQIwy/9HffxXVQt4jtzHZkGEdV3
 wRRw==
X-Gm-Message-State: APjAAAW2V4u97vL73O6eeV1FuaIIfbB7pEN/Lf67bhaMDzGRQjmvoNYO
 zFtkIg8qcHqm1WI27nsvULPQ1w==
X-Google-Smtp-Source: APXvYqwwVSNPE5KOIRDKGnKoGzgoMRg2kvhAd8LSW436lA1eY3lipqpVLe11sNrtmgGOqBltRdlWXQ==
X-Received: by 2002:a65:534b:: with SMTP id w11mr39586352pgr.210.1557857296635; 
 Tue, 14 May 2019 11:08:16 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
 by smtp.gmail.com with ESMTPSA id h18sm1568524pgv.38.2019.05.14.11.08.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 14 May 2019 11:08:15 -0700 (PDT)
Date: Tue, 14 May 2019 11:08:10 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 15/18] Documentation: kunit: add documentation for KUnit
Message-ID: <20190514180810.GA109557@google.com>
References: <20190514054251.186196-1-brendanhiggins@google.com>
 <20190514054251.186196-16-brendanhiggins@google.com>
 <20190514073422.4287267c@lwn.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514073422.4287267c@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 yamada.masahiro@socionext.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com,
 kieran.bingham@ideasonboard.com, Felix Guo <felixguoxiuping@gmail.com>,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 tytso@mit.edu, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
 daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org,
 khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 14, 2019 at 07:34:22AM -0600, Jonathan Corbet wrote:
> On Mon, 13 May 2019 22:42:49 -0700
> Brendan Higgins <brendanhiggins@google.com> wrote:
> 
> > Add documentation for KUnit, the Linux kernel unit testing framework.
> > - Add intro and usage guide for KUnit
> > - Add API reference
> > 
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> > Changes Since Last Revision:
> >  - Addressed reference to incorrect number of sections, as per Randy's
> >    comment.
> >  - Make section underlines same length as the section title, as per
> >    Randy's comments.
> > ---
> >  Documentation/index.rst           |   1 +
> >  Documentation/kunit/api/index.rst |  16 +
> >  Documentation/kunit/api/test.rst  |  14 +
> >  Documentation/kunit/faq.rst       |  62 ++++
> >  Documentation/kunit/index.rst     |  79 ++++
> >  Documentation/kunit/start.rst     | 180 ++++++++++
> >  Documentation/kunit/usage.rst     | 575 ++++++++++++++++++++++++++++++
> 
> Certainly it's great to see all this documentation coming with this
> feature!
> 
> Naturally, though, I have one request: I'd rather not see this at the top
> level, which is more than crowded enough as it is.  Can this material
> please go into the development tools book, alongside the kselftest
> documentation?

Oh yeah, that seems like the obvious home for this in hindsight. Sorry
about that. Will fix in next revision!

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
