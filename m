Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A76038AB34
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 01:33:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF43E213281D7;
	Mon, 12 Aug 2019 16:36:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2C98E213030A5
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 16:36:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n9so44033785pgc.1
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LTfhhIMEVWBJ1fQ8dSU/yBqkpCSWczjteIKFZOpbLX8=;
 b=c9dOYm8jUrYmRfI5dEYJE2Wdnda5vlKFp8TRu/bv1paeS5Nb3I93x9HcYZ5ednOIno
 wGUiE4FUkpp0oe3pnvKv6pG5E0pSyHTSelc+rec86VL0eKpaX1nLvJb20gWSbR51tasf
 pgzzqgph/ELjX9q8SLyXYbEtVD5OMe2Bv9/Yd1k25uiMzejzz4xG8apO6djfJpMz8vcn
 XxJ7D8O/Gc8sfv/yWGdO+KIi2sqttmFcaUq9dKaYH8/xsyQWTJSFN1Jmxc4txyx4aB+z
 WGBS3gigW8iS9W0dFVg6j9MrUrNTENxkLxw6lLoD3AWXnMP8qmgG1uCcjQTNKLdPM7ys
 zaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LTfhhIMEVWBJ1fQ8dSU/yBqkpCSWczjteIKFZOpbLX8=;
 b=IfK1Z7vWqvMh5/M0w1w9kn6HApn3FOIc32vLV4s0SCYKZYd8Qw7CcufphIMG83Ch9K
 m8mQATx+mrOIwEh2pekOCpSVHz6bTb19jO+vrRgOmzZGHha4E8bCfH0HDi6NvjZvVkK8
 pUG9CmQJX/SjrQ1z3K2wirwibT/CjfJBlqWhzO9V83zZ1uRq9NLHWUsbwtljMzKA3Y3c
 cE16uI3wgtjDIld/qdk6QjECakdcYZH4nHuq+9HliiQ9JJ3F36y9Qu+kukEbTesZ3eMg
 jzAXs/Gl6pNOVbj75ji5RTcrMecKt0s4bSOxrSnSHiHBCeBXmWvRPXNI23O1WEDAgEXv
 35HQ==
X-Gm-Message-State: APjAAAVFyw+JfKprbpqTBWNGLgfRCyLPbsUdonb7kgOBjHDghVr+mPZm
 jDBTTaD0iLAkvoSdYjn+JEOytQ==
X-Google-Smtp-Source: APXvYqxcDoap4N3EkfxGt7+4TrFgEHcuwub7I5n6cGzvsvHggQpTuDBEDm80K9tY5UT8aKNLpSv+9A==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr31927403pgq.415.1565652822096; 
 Mon, 12 Aug 2019 16:33:42 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
 by smtp.gmail.com with ESMTPSA id j187sm13658683pfg.178.2019.08.12.16.33.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 16:33:41 -0700 (PDT)
Date: Mon, 12 Aug 2019 16:33:36 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
Message-ID: <20190812233336.GA224410@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190812225520.5A67C206A2@mail.kernel.org>
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

On Mon, Aug 12, 2019 at 03:55:19PM -0700, Stephen Boyd wrote:
> Quoting Brendan Higgins (2019-08-12 11:24:06)
> > +void string_stream_clear(struct string_stream *stream)
> > +{
> > +       struct string_stream_fragment *frag_container, *frag_container_safe;
> > +
> > +       spin_lock(&stream->lock);
> > +       list_for_each_entry_safe(frag_container,
> > +                                frag_container_safe,
> > +                                &stream->fragments,
> > +                                node) {
> > +               list_del(&frag_container->node);
> 
> Shouldn't we free the allocation here? Otherwise, if some test is going
> to add, add, clear, add, it's going to leak until the test is over?

So basically this means I should add a kunit_kfree and
kunit_resource_destroy (respective equivalents to devm_kfree, and
devres_destroy) and use kunit_kfree here?

> > +       }
> > +       stream->length = 0;
> > +       spin_unlock(&stream->lock);
> > +}
> > +
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
