Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC98ABC1
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 02:04:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6690421329970;
	Mon, 12 Aug 2019 17:06:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F2908213281FF
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 17:01:57 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 100842063F;
 Mon, 12 Aug 2019 23:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565654380;
 bh=Ihx5qucsrmvrAAE/5ImD3U15K8tabsAl8VFviXM9+Bg=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=fIGb9dkjeLM6ykUlYcegOGMgH57XYg0i2e09hxpU6M5SeZwLGIFKwZRTa3F446++Q
 7v31k+Hz3Z3dkW7F1eUzFN+GhoaUfon3TmFOSQ+Kek1TG5+5BWGh5EPASd4FKHvy+z
 H+flEKxiF+rQtxdwpE+w2sauD520cIpSgMU1N6LU=
MIME-Version: 1.0
In-Reply-To: <20190812233336.GA224410@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date: Mon, 12 Aug 2019 16:59:39 -0700
Message-Id: <20190812235940.100842063F@mail.kernel.org>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 amir73il@gmail.com, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Quoting Brendan Higgins (2019-08-12 16:33:36)
> On Mon, Aug 12, 2019 at 03:55:19PM -0700, Stephen Boyd wrote:
> > Quoting Brendan Higgins (2019-08-12 11:24:06)
> > > +void string_stream_clear(struct string_stream *stream)
> > > +{
> > > +       struct string_stream_fragment *frag_container, *frag_container_safe;
> > > +
> > > +       spin_lock(&stream->lock);
> > > +       list_for_each_entry_safe(frag_container,
> > > +                                frag_container_safe,
> > > +                                &stream->fragments,
> > > +                                node) {
> > > +               list_del(&frag_container->node);
> > 
> > Shouldn't we free the allocation here? Otherwise, if some test is going
> > to add, add, clear, add, it's going to leak until the test is over?
> 
> So basically this means I should add a kunit_kfree and
> kunit_resource_destroy (respective equivalents to devm_kfree, and
> devres_destroy) and use kunit_kfree here?
> 

Yes, or drop the API entirely? Does anything need this functionality?

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
