Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF9C1E4B6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 00:19:24 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 975DD2127674A;
	Tue, 14 May 2019 15:19:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a4a; helo=mail-vk1-xa4a.google.com;
 envelope-from=36d7bxa4kdl8gwjsifsmnllnsxlttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CFFEF2127674A
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 15:19:21 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id s5so311500vkd.0
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=AF/X8kcACMWJnbuDnmgRNv7b9D+v3mQnlvpAU165Bwk=;
 b=r21t6aRT31vNmpHaVPznC01sm7g+B5zt/jTVYWwmuo0cnbatwvGtXsLMEJPXX6zEoP
 FG3OW9ubxqr6YCydWl32PTlnIP7SYUwByExlaXM73wCCQ3+2tkORRsltrNpqpbXQAKQg
 ku0N9dvnOgGjgRfcIXdfuvX2dM54j/nmqegoGcJfCjZDaf+BMlJLXI3iiPCpya8XU7JY
 LFx44FuKPcAW8WiTPQ77zyWJaQZ0s7aW4VktCc8mNlE+0W32KYe3nQSnwjK1QUMtqM++
 KyJhT61S+DwD9fzuSDjvEkFIs3xDUSokTOYs4rKLJCr+FihvewVZ18EwM5Kjq9T6C4GP
 S+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=AF/X8kcACMWJnbuDnmgRNv7b9D+v3mQnlvpAU165Bwk=;
 b=C+/KQsdrryQ5aP076bsy90AeTdwLfmLnwQG2Urr9koDTQUbxg5/5pBw7nNVH4cH7RL
 tZKfu5oJFdxET2JhRCtFsNGNaNVZorJmHe6qdX5OOftPHvwo9hFFS0aD7oxiEZuGBGqq
 75VGUS8CggtGXyoAWquvXDVzkYTkqepgESyu5igTmlmQzCOMZugrDdEumtnmbj7OB3TK
 0tBu3gJdCR6o0frOXKThGJXzsYCKlTTxmbbo12mhiQhfJ6G50vD1+3CmJFSiXFTQDCN/
 DXG7pOoTDhVSdYWEa+xkYdIMxmnS1QQU24I71FCEcaDtb1+yQDOgIM26vpQ5xohcf7cP
 QeFA==
X-Gm-Message-State: APjAAAUdCRvwhDyXuigEwGa7T3O512u/297pgI+rM7l9yqT0SDhHXcch
 SSDj4y0TeV79vcKxL+y2zH7lXoDLOMD+n7M7jTZQvQ==
X-Google-Smtp-Source: APXvYqwzDzsNPOfRnQOJWWw03pWCA5Fjhb1qGAZ4OtAQmohRvasBoIqNe/10w5aP2fIkCU3ca5rLrh+9ahCG9LjIfitkeg==
X-Received: by 2002:a67:c508:: with SMTP id e8mr3376906vsk.18.1557872360849;
 Tue, 14 May 2019 15:19:20 -0700 (PDT)
Date: Tue, 14 May 2019 15:17:05 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 12/18] kunit: test: add tests for KUnit managed resources
From: Brendan Higgins <brendanhiggins@google.com>
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, 
 keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, 
 peterz@infradead.org, robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, 
 tytso@mit.edu, yamada.masahiro@socionext.com
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
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org,
 linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 Avinash Kondareddy <akndr41@gmail.com>, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Avinash Kondareddy <akndr41@gmail.com>

Add unit tests for KUnit managed resources. KUnit managed resources
(struct kunit_resource) are resources that are automatically cleaned up
at the end of a KUnit test, similar to the concept of devm_* managed
resources.

Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 kunit/test-test.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/kunit/test-test.c b/kunit/test-test.c
index 7afc9bb52f7be..ee926f798b266 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -101,3 +101,126 @@ static struct kunit_module kunit_try_catch_test_module = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 module_test(kunit_try_catch_test_module);
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
+};
+
+static int fake_resource_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	res->allocation = &ctx->is_resource_initialized;
+	ctx->is_resource_initialized = true;
+	return 0;
+}
+
+static void fake_resource_free(struct kunit_resource *res)
+{
+	bool *is_resource_initialized = res->allocation;
+
+	*is_resource_initialized = false;
+}
+
+static void kunit_resource_test_init_resources(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_init_test(&ctx->test, "testing_test_init_test");
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_alloc_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res;
+	kunit_resource_free_t free = fake_resource_free;
+
+	res = kunit_alloc_resource(&ctx->test,
+				   fake_resource_init,
+				   fake_resource_free,
+				   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    &ctx->is_resource_initialized, res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
+}
+
+static void kunit_resource_test_free_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_resource(&ctx->test,
+							  fake_resource_init,
+							  fake_resource_free,
+							  ctx);
+
+	kunit_free_resource(&ctx->test, res);
+
+	KUNIT_EXPECT_EQ(test, false, ctx->is_resource_initialized);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_cleanup_resources(struct kunit *test)
+{
+	int i;
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *resources[5];
+
+	for (i = 0; i < ARRAY_SIZE(resources); i++) {
+		resources[i] = kunit_alloc_resource(&ctx->test,
+						    fake_resource_init,
+						    fake_resource_free,
+						    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx)
+		return -ENOMEM;
+
+	test->priv = ctx;
+
+	kunit_init_test(&ctx->test, "test_test_context");
+
+	return 0;
+}
+
+static void kunit_resource_test_exit(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_cleanup(&ctx->test);
+	kfree(ctx);
+}
+
+static struct kunit_case kunit_resource_test_cases[] = {
+	KUNIT_CASE(kunit_resource_test_init_resources),
+	KUNIT_CASE(kunit_resource_test_alloc_resource),
+	KUNIT_CASE(kunit_resource_test_free_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	{},
+};
+
+static struct kunit_module kunit_resource_test_module = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+module_test(kunit_resource_test_module);
-- 
2.21.0.1020.gf2820cf01a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
